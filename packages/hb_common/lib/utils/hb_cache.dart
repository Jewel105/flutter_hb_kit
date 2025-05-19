// 缓存音频视频图片
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

enum FileType { voice, video, image }

// 缓存图片到本地
class HbCache {
  // 单例模式
  static HbCache? _instance;
  factory HbCache() => _instance ??= HbCache._();
  HbCache._();

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
  String _getCachePath({
    FileType fileType = FileType.image,
    bool create = true,
  }) {
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
    if (create && !dir.existsSync()) {
      dir.createSync(recursive: true);
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

  /// 删除所有文件
  Future<void> deleteAllCacheFiles() async {
    await deleteBytesToFile(fileType: FileType.image);
    await deleteBytesToFile(fileType: FileType.voice);
    await deleteBytesToFile(fileType: FileType.video);
  }

  /// 删除特定类型文件
  Future<void> deleteBytesToFile({FileType fileType = FileType.image}) async {
    documentsDirectory ??= await getApplicationSupportDirectory();
    final String systemDir = documentsDirectory!.path;
    final String cacheDir = _getCachePath(fileType: fileType, create: false);
    final Directory dir = Directory("$systemDir$cacheDir");

    if (dir.existsSync()) {
      for (var file in dir.listSync()) {
        try {
          if (file is File) {
            await file.delete();
            debugPrint("删除文件成功: ${file.path}");
          }
        } catch (e) {
          debugPrint("删除文件失败: ${file.path}, 错误: $e");
        }
      }
    }
  }

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
