import 'package:flutter/material.dart';

import '_scan_page.dart';

class HbQr {
  /// 扫描和识别二维码，扫描页面可以选择图片识别
  static Future<String?> scan(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScanPage()),
    );
  }
}
