import 'dart:io';

import 'package:hb_rename/template/_template.dart';
import 'package:hb_rename/util/_file_util.dart';

class IosTool {
  static void resetApp(String appName, String bundleId) {
    String? old = _getOldBundleId();
    if (old == null) {
      throw Exception('Bundle ID not exists');
    }
    _replaceInfoPlist();
    _updateXcconfig();
    _replaceScheme(appName);
    _updateProjectPbxproj(old, bundleId);
  }

  // ios/Runner/Info.plist
  static void _replaceInfoPlist() {
    final String infoPlistPath = './ios/Runner/Info.plist';
    final String infoPlistContent = FileUtil.readFileContent(infoPlistPath);
    // 使用正则表达式直接替换 CFBundleDisplayName 的值
    final displayNamePattern = RegExp(
      r'(<key>CFBundleDisplayName</key>\s*<string>)(.*?)(</string>)',
      dotAll: true,
    );

    final updateContent = infoPlistContent.replaceFirst(
      displayNamePattern,
      Template.iosDisplayName,
    );
    File(infoPlistPath).writeAsString(updateContent);
  }

  // ios/Flutter/Release.xcconfig
  // ios/Flutter/Debug.xcconfig
  static void _updateXcconfig() {
    final String xDebugConfigPath = "./ios/Flutter/Debug.xcconfig";
    final String xReleaseConfigPath = "./ios/Flutter/Release.xcconfig";
    final xDebugConfigContent = FileUtil.readFileContent(xDebugConfigPath);
    final xReleaseConfigContent = FileUtil.readFileContent(xReleaseConfigPath);
    File(
      xDebugConfigPath,
    ).writeAsString(xDebugConfigContent + Template.xConfig);
    File(
      xReleaseConfigPath,
    ).writeAsString(xReleaseConfigContent + Template.xConfig);
  }

  // ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  static void _replaceScheme(String appName) {
    final String xcSchemePath =
        './ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme';
    final xcsSchemeContent = FileUtil.readFileContent(xcSchemePath);
    String updatedContent = xcsSchemeContent.replaceFirst(
      'version = "1.3"',
      'version = "1.7"',
    );
    updatedContent = FileUtil.insertBeforeLineInContent(
      updatedContent,
      "<BuildActionEntries>",
      Template.getXcScheme(appName),
    );
    File(xcSchemePath).writeAsString(updatedContent);
  }

  // ios/Runner.xcodeproj/project.pbxproj
  static void _updateProjectPbxproj(String oldBunldId, String newBundleId) {
    // 尝试从 project.pbxproj 文件获取
    final pbxprojPath = './ios/Runner.xcodeproj/project.pbxproj';
    final pbxprojContent = FileUtil.readFileContent(pbxprojPath);
    String updatedContent = pbxprojContent.replaceAll(oldBunldId, newBundleId);

    final pattern = RegExp(
      '(PRODUCT_BUNDLE_IDENTIFIER\\s*=\\s*)(?:"|\')?$newBundleId(?:"|\')?(\\s*;)',
    );

    updatedContent = updatedContent.replaceAllMapped(pattern, (match) {
      // 保留等号前的部分，替换等号后的部分
      return Template.getIosBundleId(newBundleId);
    });

    File(pbxprojPath).writeAsString(updatedContent);
  }

  static String? _getOldBundleId() {
    // 尝试从 project.pbxproj 文件获取
    final pbxprojPath = './ios/Runner.xcodeproj/project.pbxproj';
    final pbxprojContent = FileUtil.readFileContent(pbxprojPath);

    final bundleIdPattern = RegExp(
      r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*([^;\n]+)',
    );
    // 直接获取第一个匹配
    final match = bundleIdPattern.firstMatch(pbxprojContent);
    if (match != null) {
      return match.group(1)?.trim();
    }
    return null;
  }
}
