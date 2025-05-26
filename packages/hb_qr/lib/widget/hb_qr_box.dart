import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HbQrBox extends StatelessWidget {
  final String data;
  final double size;

  const HbQrBox({super.key, required this.data, this.size = 200});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 全屏显示二维码
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Material(
                child: Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: 0.9.sw,
                    child: QrImageView(
                      data: data,
                      size: size,
                      padding: const EdgeInsets.all(6),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: SizedBox(
        width: size,
        child: QrImageView(
          data: data,
          size: size,
          padding: const EdgeInsets.all(6),
        ),
      ),
    );
  }
}
