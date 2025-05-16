// 缓存音频视频图片
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

enum FileType { voice, video, image }

// 缓存图片到本地
class HbCacheUtil {
  // 单例模式
  static HbCacheUtil? _instance;
  factory HbCacheUtil() => _instance ??= HbCacheUtil._();
  HbCacheUtil._();

  static Directory? documentsDirectory;

  final HttpClient _httpClient =
      HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

  /// 获取url字符串的MD5值
  String _getUrlMd5(String url, {FileType fileType = FileType.image}) {
    List<int> content = const Utf8Encoder().convert(url);
    String digest = md5.convert(content).toString().split(".").join("");
    switch (fileType) {
      case FileType.voice:
        return '$digest.aac';
      case FileType.video:
        var list = url.substring(url.length - 10, url.length).split('.');
        if (list.length == 1) {
          list = ['mp4'];
        }
        var suffix = list.removeLast();
        return '$digest.$suffix';
      case FileType.image:
        var list = url.substring(url.length - 10, url.length).split('.');
        if (list.length == 1) {
          list = ['png'];
        }
        var suffix = list.removeLast();
        return '$digest.$suffix';
    }
  }

  /// 获取文件缓存路径目录
  String _getCachePath({FileType fileType = FileType.image}) {
    late final String cachePath;
    switch (fileType) {
      case FileType.image:
        cachePath = "/imagecache";
        break;
      case FileType.voice:
        cachePath = "/voicecache";
        break;
      case FileType.video:
        cachePath = "/videocache";
    }
    var dir = Directory("${documentsDirectory!.path}$cachePath");
    if (!dir.existsSync()) {
      dir.createSync();
    }
    return cachePath;
  }

  // 保存网络图片
  Future<void> _saveFile(String url, File file, String path) async {
    if (url.startsWith('http')) {
      Uint8List bytes = await _getImage(url);
      file.createSync();
      await file.writeAsBytes(bytes);
    } else {
      final File imageFile = File(url);
      // 将图片文件复制到目标文件夹
      await imageFile.copy(path);
    }
  }

  // 获取图片
  Future<Uint8List> _getImage(String url) async {
    final Uri resolved = Uri.base.resolve(url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception(
        'HTTP request failed, statusCode: ${response.statusCode}, $resolved',
      );
    }
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    return bytes;
  }

  /// 删除文件
  // Future deleteBytesToFile({FileType fileType = FileType.image}) async {
  //   int day = DateTime.now().day;
  //   if (day == 1 || day == 01) {
  //     var tempDir = Directory(await _getCachePath(fileType: fileType));
  //     // 遍历文件夹中的所有文件
  //     tempDir.listSync().forEach((element) {
  //       element.deleteSync();
  //       debugPrint("删除文件成功");
  //     });
  //     // //删除目录
  //     // tempDir.deleteSync();
  //     // assert(await tempDir.exists() == false);
  //   }
  // }

  /// 获取图片，并保存图片到本地，并返回图片
  /// returnAllPath: true全部，false：只返回后半部分
  Future<String> getFile(
    String url, {
    FileType fileType = FileType.image,
    bool returnAllPath = true,
  }) async {
    try {
      documentsDirectory ??= await getApplicationSupportDirectory();
      final String systemDir = documentsDirectory!.path;
      final String cacheDir = _getCachePath(fileType: fileType);
      final String urlMd5 = _getUrlMd5(url, fileType: fileType);
      final File file = File("$systemDir$cacheDir/$urlMd5");
      if (!file.existsSync()) {
        // 不存在先保存
        await _saveFile(url, file, "$systemDir$cacheDir/$urlMd5");
      }
      if (returnAllPath) return "$systemDir$cacheDir/$urlMd5";
      return "$cacheDir/$urlMd5";
    } catch (_) {
      return '';
    }
  }

  /// 拼接本地路径
  static String getLocalFilePath(String path) {
    return "${documentsDirectory!.path}$path";
  }
}
