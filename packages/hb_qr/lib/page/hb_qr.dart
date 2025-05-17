import 'package:flutter/material.dart';

import '_scan_page.dart';

class HbQr {
  static Future<String?> scan(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScanPage()),
    );
  }
}
