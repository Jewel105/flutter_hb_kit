import 'dart:convert';

import 'package:crypto/crypto.dart' show sha256, Digest;
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class HbCrypto {
  /// Base64 编码和解码
  static String toBase64(String input) {
    // 将字符串转为字节数组
    List<int> bytes = utf8.encode(input);
    // 使用 Base64 编码
    String base64String = base64.encode(bytes);
    return base64String;
  }

  /// Base64 解码
  static String fromBase64(String base64String) {
    // Base64 解码
    List<int> bytes = base64.decode(base64String);
    // 将字节数组转为字符串
    String decodedString = utf8.decode(bytes);
    return decodedString;
  }

  /// SHA-256 哈希值
  static String sha256String(String text) {
    // 将字符串转换为字节数组
    List<int> bytes = utf8.encode(text);
    // 计算 SHA-256 哈希值
    Digest sha256Hash = sha256.convert(bytes);
    return sha256Hash.toString();
  }

  /// 公钥加密
  static String encryptString(String text, String public) {
    final RSAPublicKey publicKey = RSAKeyParser().parse(public) as RSAPublicKey;
    final Encrypter encrypter = Encrypter(RSA(publicKey: publicKey));
    final Encrypted encrypted = encrypter.encrypt(text);
    final String encryptStr = encrypted.base64;
    return encryptStr;
  }

  /// 私钥解密
  static String decryptString(String encryptStr, String private) {
    final RSAPrivateKey privateKey =
        RSAKeyParser().parse(private) as RSAPrivateKey;
    final Encrypter decrypter = Encrypter(RSA(privateKey: privateKey));
    final String decrypted = decrypter.decrypt64(encryptStr);
    return decrypted;
  }

  /// 私钥签名
  static String signString(String text, String private) {
    final RSAPrivateKey privateKey =
        RSAKeyParser().parse(private) as RSAPrivateKey;
    final Signer signer = Signer(
      RSASigner(RSASignDigest.SHA256, privateKey: privateKey),
    );
    String signerStr = signer.sign(text).base64;
    return signerStr;
  }

  /// 公钥验签名
  static bool verifyString(String message, String signature, String public) {
    // 解析公钥和私钥
    final RSAPublicKey publicKey = RSAKeyParser().parse(public) as RSAPublicKey;
    // 创建用于签名和验证的Signer
    final Signer signer = Signer(
      RSASigner(RSASignDigest.SHA256, publicKey: publicKey),
    );
    bool isVerify = signer.verify(message, Encrypted.from64(signature));
    return isVerify;
  }
}
