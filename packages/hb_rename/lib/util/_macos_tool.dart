import 'dart:io';

import 'package:hb_rename/template/_template.dart';
import 'package:hb_rename/util/_file_util.dart';

class MacosTool {
  static void resetApp(String appName, String bundleId) {
    _replaceAppInfo(bundleId);
    _updateXcconfig();
    _replaceScheme(appName);
  }

  static void _replaceAppInfo(String bundleId) {
    final appInfoPath = './macos/Runner/Configs/AppInfo.xcconfig';
    final appInfoContent = FileUtil.readFileContent(appInfoPath);

    String? oldBundleId = _getOldBundleId(appInfoContent);
    if (oldBundleId == null) {
      throw Exception('Bundle ID not exists');
    }

    String? oldName = _getOldAppName(appInfoContent);
    if (oldName == null) {
      throw Exception('APP Name ID not exists');
    }
    String newAppInfoContent = appInfoContent.replaceAll(
      oldBundleId,
      "$bundleId\${APP_SUFFIX}",
    );
    newAppInfoContent = newAppInfoContent.replaceAll(oldName, "\${APP_NAME}");
    File(appInfoPath).writeAsString(newAppInfoContent);
  }

  // macos/Flutter/Flutter-Debug.xcconfig
  // macos/Flutter/Flutter-Release.xcconfig
  static void _updateXcconfig() {
    final String xDebugConfigPath = "./macos/Flutter/Flutter-Debug.xcconfig";
    final String xReleaseConfigPath =
        "./macos/Flutter/Flutter-Release.xcconfig";
    final xDebugConfigContent = FileUtil.readFileContent(xDebugConfigPath);
    final xReleaseConfigContent = FileUtil.readFileContent(xReleaseConfigPath);
    if (!xDebugConfigContent.contains(Template.xConfig)) {
      File(
        xDebugConfigPath,
      ).writeAsString(xDebugConfigContent + Template.xConfig);
    }
    if (!xReleaseConfigContent.contains(Template.xConfig)) {
      File(
        xReleaseConfigPath,
      ).writeAsString(xReleaseConfigContent + Template.xConfig);
    }
  }

  // macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  static void _replaceScheme(String appName) {
    final String xcSchemePath =
        './macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme';
    final xcsSchemeContent = FileUtil.readFileContent(xcSchemePath);
    var oldBuildableName = _getOldBuildableName(xcsSchemeContent);
    if (oldBuildableName == null) {
      throw Exception('Buildable Name not exists');
    }
    _updateProjectPbxproj(oldBuildableName, "$appName.app");

    String updatedContent = xcsSchemeContent.replaceFirst(
      'version = "1.3"',
      'version = "1.7"',
    );

    if (updatedContent.contains("Run Script")) {
      // 如果本身就存在 删除老的 Run Script
      final pattern = RegExp(
        r'<PreActions>[\s\S]*?</PreActions>',
        multiLine: true,
      );
      updatedContent = updatedContent.replaceAll(pattern, '');
    }

    updatedContent = FileUtil.insertBeforeLineInContent(
      updatedContent,
      "<BuildActionEntries>",
      Template.getMacXcScheme(appName),
    );
    updatedContent = updatedContent.replaceAll(
      oldBuildableName,
      "$appName.app",
    );
    File(xcSchemePath).writeAsString(updatedContent);
  }

  // 获取旧的BuildableName
  static String? _getOldBuildableName(String xcsSchemeContent) {
    final pattern = RegExp(
      r'''(?:BuildableName)\s*=\s*(['"])(.+?)\1''',
      caseSensitive: false,
    );

    final match = pattern.firstMatch(xcsSchemeContent);

    if (match != null && match.groupCount >= 2) {
      // 返回匹配到的命名空间值
      return match.group(2)!;
    }
    return null;
  }

  // macos/Runner.xcodeproj/project.pbxproj
  static void _updateProjectPbxproj(
    String oldBuildableName,
    String newBuildableName,
  ) {
    // 尝试从 project.pbxproj 文件获取
    final pbxprojPath = './macos/Runner.xcodeproj/project.pbxproj';
    final pbxprojContent = FileUtil.readFileContent(pbxprojPath);
    String updatedContent = pbxprojContent.replaceAll(
      oldBuildableName,
      newBuildableName,
    );

    File(pbxprojPath).writeAsString(updatedContent);
  }

  static String? _getOldBundleId(String appInfoContent) {
    final bundleIdPattern = RegExp(
      r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*([^;\n]+)',
    );
    // 直接获取第一个匹配
    final match = bundleIdPattern.firstMatch(appInfoContent);
    if (match != null) {
      return match.group(1)?.trim();
    }
    return null;
  }

  static String? _getOldAppName(String appInfoContent) {
    final bundleIdPattern = RegExp(r'PRODUCT_NAME\s*=\s*([^;\n]+)');
    // 直接获取第一个匹配
    final match = bundleIdPattern.firstMatch(appInfoContent);
    if (match != null) {
      return match.group(1)?.trim();
    }
    return null;
  }
}
