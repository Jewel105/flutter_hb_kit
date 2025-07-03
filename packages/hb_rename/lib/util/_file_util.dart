import 'dart:io';

class FileUtil {
  /// 读取文本内容并检查是否存在
  static String readFileContent(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('File not found: $filePath');
    }
    return file.readAsStringSync();
  }

  /// 在文本内容中查找特定行并在其前面插入内容
  /// 返回修改后的文本内容，如果未找到目标行则返回原内容
  static String insertBeforeLineInContent(
    String content,
    String targetLine,
    String insertionContent,
  ) {
    final lines = content.split('\n');
    final targetIndex = lines.indexWhere((line) => line.trim() == targetLine);

    if (targetIndex != -1) {
      final newLines = List<String>.from(lines);
      newLines.insert(targetIndex, insertionContent.trim());
      return newLines.join('\n');
    }

    return content; // 未找到目标行时返回原内容
  }

  /// 替换前面是特定内容，然后=不固定内容的情况
  /// 例如：namespace = "com.hambit.equipment"，android:label="xxxxx"
  static String replaceAttribute(
    String content,
    String attribute,
    String newContent,
  ) {
    final pattern = RegExp(
      '$attribute\\s*=\\s*(["\'])(?:(?=(\\\\?))\\2.)*?\\1',
      caseSensitive: false,
    );

    // 替换为统一的字符串资源引用
    String updatedContent = content.replaceAllMapped(pattern, (match) {
      return newContent;
    });

    return updatedContent;
  }

  /// 在 Dart/Flutter 代码中，在特定的 map 对象下方插入内容（支持嵌套花括号）
  /// [content] - 原始文本内容
  /// [mapIdentifier] - 要匹配的 map 对象标识符（如变量名或属性名）
  /// [insertContent] - 要插入的内容
  /// [afterClosingBrace] - 是否在闭合花括号后插入（默认为 false)
  static String insertAfterMap(
    String content,
    String mapIdentifier,
    String insertContent, {
    bool afterClosingBrace = false,
  }) {
    // 转义标识符中的特殊字符
    final escapedIdentifier = RegExp.escape(mapIdentifier);

    // 匹配 map 标识符和开始花括号
    final startPattern = RegExp(
      '$escapedIdentifier\\s*\\{',
      caseSensitive: false,
    );

    final startMatch = startPattern.firstMatch(content);
    if (startMatch == null) return content;

    // 从开始花括号位置开始解析，计算嵌套层级
    int braceLevel = 0;
    bool inString = false;
    bool inSingleQuote = false;
    bool inDoubleQuote = false;
    bool inComment = false;
    bool inMultiLineComment = false;

    int currentIndex = startMatch.start;
    int endIndex = -1;

    // 遍历字符，计算花括号层级
    while (currentIndex < content.length) {
      final char = content[currentIndex];

      // 处理注释
      if (!inMultiLineComment) {
        if (char == '/' && currentIndex + 1 < content.length) {
          final nextChar = content[currentIndex + 1];
          if (nextChar == '/' && !inString) {
            inComment = true;
          } else if (nextChar == '*' && !inString) {
            inMultiLineComment = true;
          }
        }
      }

      if (inComment && char == '\n') {
        inComment = false;
      }

      if (inMultiLineComment &&
          char == '*' &&
          currentIndex + 1 < content.length) {
        if (content[currentIndex + 1] == '/') {
          inMultiLineComment = false;
          currentIndex++; // 跳过 '/'
        }
      }

      // 跳过注释
      if (inComment || inMultiLineComment) {
        currentIndex++;
        continue;
      }

      // 处理字符串
      if (char == '\'' && !inDoubleQuote && content[currentIndex - 1] != '\\') {
        inSingleQuote = !inSingleQuote;
        inString = inSingleQuote;
      }

      if (char == '"' && !inSingleQuote && content[currentIndex - 1] != '\\') {
        inDoubleQuote = !inDoubleQuote;
        inString = inDoubleQuote;
      }

      // 跳过字符串中的内容
      if (inString) {
        currentIndex++;
        continue;
      }

      // 计算花括号层级
      if (char == '{') {
        braceLevel++;
      } else if (char == '}') {
        braceLevel--;

        if (braceLevel == 0) {
          endIndex = currentIndex;
          break;
        }
      }

      currentIndex++;
    }

    // 如果找到完整的 map 对象
    if (endIndex != -1) {
      if (afterClosingBrace) {
        // 在闭合花括号后插入
        return '${content.substring(0, endIndex + 1)}\n$insertContent${content.substring(endIndex + 1)}';
      } else {
        // 在闭合花括号前插入（map 内部）
        return '${content.substring(0, endIndex)}\n$insertContent\n${content.substring(endIndex)}';
      }
    }
    return content; // 未找到完整的 map 对象
  }

  /// 删除文本中包含指定字符串的第一行
  /// [content] - 总内容
  /// [targetString] - 目标字符串
  static String removeLineByString(String content, String targetString) {
    final lines = content.split('\n');
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].contains(targetString)) {
        lines.removeAt(i); // 删除匹配行
        return lines.join('\n');
      }
    }
    return content; // 未找到匹配行时返回原文本
  }

  /// 递归删除空目录
  static Future<void> deleteEmptyDirectories(Directory dir) async {
    // 如果目录不存在，直接返回
    if (!await dir.exists()) return;

    // 获取目录中的所有文件和子目录
    final entities = await dir.list().toList();

    // 如果目录不为空，不删除
    if (entities.isNotEmpty) {
      return;
    }

    // 目录为空，尝试删除
    try {
      await dir.delete();

      // 递归检查父目录
      await deleteEmptyDirectories(dir.parent);
    } catch (e) {
      rethrow;
    }
  }
}
