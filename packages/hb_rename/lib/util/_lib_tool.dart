import 'dart:io';

import 'package:hb_rename/template/_template.dart';
import 'package:hb_rename/util/_file_util.dart';

class LibTool {
  static resetApp(String appName) {
    _replaceMainTitle(appName);
  }

  // lib/main.dart
  static void _replaceMainTitle(String appName) {
    final String mainPath = './lib/main.dart';
    final String mainContent = FileUtil.readFileContent(mainPath);
    // 使用正则表达式替换单引号或双引号的 title
    final pattern = RegExp(r'''title:\s*['\"](.*?)['\"],''');
    String updatedContent = mainContent.replaceAllMapped(pattern, (match) {
      return Template.getMainTitle(appName); // 统一使用单引号
    });
    File(mainPath).writeAsString(updatedContent);
  }
}
