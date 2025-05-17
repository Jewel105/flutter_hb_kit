import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HbQrBox extends StatelessWidget {
  final String data;
  final double size;

  const HbQrBox({super.key, required this.data, this.size = 200});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: QrImageView(
        data: data,
        size: size,
        padding: const EdgeInsets.all(6),
      ),
    );
  }
}
