import 'dart:io';

import 'package:hb_rename/template/_template.dart';
import 'package:hb_rename/util/_file_util.dart';

class AndroidTool {
  static void resetApp(String appName, String bundleId) {
    var oldPackageId = _getOldAppBundleId();
    _replaceAndroidManifest();
    _replaceBuildGradle(appName, bundleId);
    _replaceMainActivity(bundleId, oldPackageId);
  }

  static void _replaceAndroidManifest() {
    String manifestPath = './android/app/src/main/AndroidManifest.xml';
    final String manifestContent = FileUtil.readFileContent(manifestPath);
    // 替换为统一的字符串资源引用
    String updatedContent = FileUtil.replaceAttribute(
      manifestContent,
      'android:label',
      Template.androidManifestAppName,
    );
    // 写入更新后的内容
    File(manifestPath).writeAsString(updatedContent);
  }

  static void _replaceBuildGradle(String? appName, String? bundleId) {
    String buildGradlePath = './android/app/build.gradle';
    final String buildGradleContent = FileUtil.readFileContent(buildGradlePath);

    String updatedContent = FileUtil.insertBeforeLineInContent(
      buildGradleContent,
      "android {",
      Template.androidDartEnv,
    );

    if (bundleId != null) {
      // template 中的命名空间
      var namespaceTemplate = Template.getNamespaceString(bundleId);

      // 替换为新的命名空间
      updatedContent = FileUtil.replaceAttribute(
        updatedContent,
        'namespace',
        namespaceTemplate,
      );
      // 替换application
      var applicationIdTemplate = Template.getApplicationId(bundleId);
      updatedContent = FileUtil.replaceAttribute(
        updatedContent,
        'applicationId',
        applicationIdTemplate,
      );
    }

    if (appName != null) {
      var resValueAppName = Template.getResValueAppName(appName);
      updatedContent = FileUtil.insertAfterMap(
        updatedContent,
        'defaultConfig',
        resValueAppName,
      );
    }

    // 写入更新后的内容
    File(buildGradlePath).writeAsString(updatedContent);
  }

  /// 替换 MainActivity.kt文件的内容
  static void _replaceMainActivity(
    String? newBundleId,
    String? oldBundleId,
  ) async {
    if (newBundleId == null || oldBundleId == null) {
      return;
    }
    if (newBundleId == oldBundleId) return;
    final oldPackagePath = oldBundleId.replaceAll('.', '/');
    final oldFilePath =
        './android/app/src/main/kotlin/$oldPackagePath/MainActivity.kt';
    final mainActivityContent = FileUtil.readFileContent(oldFilePath);
    // 替换旧包名为新包名
    final updateContent = mainActivityContent.replaceAll(
      oldBundleId,
      newBundleId,
    );

    // 3. 构建新的文件路径
    final newPackagePath = newBundleId.replaceAll('.', '/');
    final newDirPath = './android/app/src/main/kotlin/$newPackagePath';
    final newFilePath = '$newDirPath/MainActivity.kt';
    // 4. 创建新目录（如果不存在）
    final newDir = Directory(newDirPath);
    if (!await newDir.exists()) {
      await newDir.create(recursive: true);
    }
    File(newFilePath).writeAsString(updateContent);
    //  删除旧文件和目录
    var oldFile = File(oldFilePath);
    await oldFile.delete();
    await FileUtil.deleteEmptyDirectories(oldFile.parent);
  }

  static String? _getOldAppBundleId() {
    String buildGradlePath = './android/app/build.gradle';
    final String buildGradleContent = FileUtil.readFileContent(buildGradlePath);
    // 正则表达式匹配 namespace 属性
    // 支持两种格式:
    // 1. build.gradle: namespace 'com.example.app' 或 namespace "com.example.app"
    // 2. AndroidManifest.xml: xmlns:android="http://schemas.android.com/apk/res/android" package="com.example.app"
    final pattern = RegExp(
      r'''(?:namespace|package)\s*=\s*(['"])(.+?)\1''',
      caseSensitive: false,
    );

    final match = pattern.firstMatch(buildGradleContent);

    if (match != null && match.groupCount >= 2) {
      // 返回匹配到的命名空间值
      return match.group(2)!;
    }
    return null;
  }
}
