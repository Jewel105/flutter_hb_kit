import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../localization/hb_qr_localizations.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
  );

  StreamSubscription<Object?>? _subscription;

  /// When detected a barcode, navigate back with the result
  void _handleBarcode(BarcodeCapture barcodes) {
    EasyThrottle.throttle('SCAN_HANDLER_TAG', Durations.extralong4, () {
      Barcode? barcode = barcodes.barcodes.firstOrNull;
      var scanResult = barcode?.rawValue;
      if (scanResult != null) {
        Navigator.of(context).pop(scanResult);
      } else {
        // QR code not detected
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = controller.barcodes.listen(_handleBarcode);
    // unawaited(controller.start());
    // WidgetsBinding.instance.addPostFrameCallback((_) {});
    // Future.microtask(() => unawaited(controller.start()));
    // 等待 MobileScanner widget 构建完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(controller.start());
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      openAppSettings();
      return;
    }
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);
        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  void _chooseImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final BarcodeCapture? barcodes = await controller.analyzeImage(image.path);
    if (barcodes == null) return;
    _handleBarcode(barcodes);
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).topCenter(Offset(0, 330.h)),
      width: 250.w,
      height: 250.w,
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Android 白色图标
        statusBarBrightness: Brightness.dark, // iOS 白色文字
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            MobileScanner(
              scanWindow: scanWindow,
              controller: controller,
              errorBuilder: (context, error) {
                return ScannerErrorWidget(error: error);
              },
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withAlpha(150),
              child: SafeArea(
                minimum: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                if (!value.isInitialized ||
                    !value.isRunning ||
                    value.error != null) {
                  return const SizedBox();
                }
                return CustomPaint(
                  painter: ScannerOverlay(scanWindow: scanWindow),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                minimum: EdgeInsets.fromLTRB(32.w, 32.w, 32.w, 48.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withAlpha(150),
                      ),
                      child: ToggleFlashlightButton(controller: controller),
                    ),
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withAlpha(150),
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.image_outlined),
                        iconSize: 36.w,
                        onPressed: _chooseImage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({required this.scanWindow, this.borderRadius = 12.0});

  final Rect scanWindow;
  final double borderRadius;
  final double borderLength = 50;

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6.0;
    _drawLeftTopCorner(canvas, borderPaint);
    _drawRightTopCorner(canvas, borderPaint);
    _drawLeftBottomCorner(canvas, borderPaint);
    _drawRightBottomCorner(canvas, borderPaint);
  }

  void _drawLeftTopCorner(Canvas canvas, Paint borderPaint) {
    final path = Path();
    path.moveTo(scanWindow.left, scanWindow.top + borderLength);
    path.lineTo(scanWindow.left, scanWindow.top + borderRadius);
    // add round arc
    path.arcToPoint(
      Offset(scanWindow.left + borderRadius, scanWindow.top), // 弧的终点
      radius: Radius.circular(borderRadius), // 圆角半径
      clockwise: true,
    );
    path.lineTo(scanWindow.left + borderLength, scanWindow.top);

    canvas.drawPath(path, borderPaint);
  }

  void _drawRightTopCorner(Canvas canvas, Paint borderPaint) {
    final path = Path();
    path.moveTo(scanWindow.right, scanWindow.top + borderLength);
    path.lineTo(scanWindow.right, scanWindow.top + borderRadius);
    // add round arc
    path.arcToPoint(
      Offset(scanWindow.right - borderRadius, scanWindow.top), // 弧的终点
      radius: Radius.circular(borderRadius), // 圆角半径
      clockwise: false,
    );
    path.lineTo(scanWindow.right - borderLength, scanWindow.top);
    canvas.drawPath(path, borderPaint);
  }

  void _drawLeftBottomCorner(Canvas canvas, Paint borderPaint) {
    final path = Path();
    path.moveTo(scanWindow.left, scanWindow.bottom - borderLength);
    path.lineTo(scanWindow.left, scanWindow.bottom - borderRadius);
    // add round arc
    path.arcToPoint(
      Offset(scanWindow.left + borderRadius, scanWindow.bottom), // 弧的终点
      radius: Radius.circular(borderRadius), // 圆角半径
      clockwise: false,
    );
    path.lineTo(scanWindow.left + borderLength, scanWindow.bottom);
    canvas.drawPath(path, borderPaint);
  }

  void _drawRightBottomCorner(Canvas canvas, Paint borderPaint) {
    final path = Path();
    path.moveTo(scanWindow.right, scanWindow.bottom - borderLength);
    path.lineTo(scanWindow.right, scanWindow.bottom - borderRadius);
    // add round arc
    path.arcToPoint(
      Offset(scanWindow.right - borderRadius, scanWindow.bottom), // 弧的终点
      radius: Radius.circular(borderRadius), // 圆角半径
      clockwise: true,
    );
    path.lineTo(scanWindow.right - borderLength, scanWindow.bottom);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}

class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return IconButton(
              color: Colors.white,
              iconSize: 32.w,
              icon: const Icon(Icons.flash_auto),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.off:
            return IconButton(
              color: Colors.white,
              iconSize: 32.w,
              icon: const Icon(Icons.flashlight_off),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.on:
            return IconButton(
              color: Colors.white,
              iconSize: 32.w,
              icon: const Icon(Icons.flashlight_on),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.unavailable:
            return SizedBox.square(
              dimension: 48.0,
              child: Icon(Icons.no_flash, size: 32.w, color: Colors.grey),
            );
        }
      },
    );
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;
    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = HbQrLocalizations.current.controllerNotReady;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = HbQrLocalizations.current.permissionDenied;
      case MobileScannerErrorCode.unsupported:
        errorMessage = HbQrLocalizations.current.scanUnsupported;
      default:
        errorMessage = HbQrLocalizations.current.genericError;
        break;
    }

    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 230.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Icon(Icons.error, color: Colors.white, size: 48.w),
          ),
          Text(errorMessage, style: const TextStyle(color: Colors.white)),
          Text(
            error.errorDetails?.message ?? '',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
