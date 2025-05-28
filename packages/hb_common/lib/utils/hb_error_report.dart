import 'dart:async';

import 'package:flutter/foundation.dart';

/// A utility class for handling and reporting errors in Flutter applications.
///
/// This class provides a comprehensive error handling solution by:
/// 1. Capturing uncaught asynchronous errors using custom Zone
/// 2. Intercepting Flutter's synchronous errors
/// 3. Providing a mechanism to report errors to external services
///
/// Usage:
/// ```dart
/// void main() {
///  final errorReport = HbErrorReport(
///   reportError: (error, stackTrace) {
///     // Send error to your analytics service
///   }
///  );
///  // Run the app within the error-handling zone
///   errorReport.errorHandlingZone.run(()  {
///     runApp(const MyApp());
///   });
/// }
/// ```

class HbErrorReport {
  late final Zone errorHandlingZone;
  final void Function(Object error, StackTrace? stackTrace)? reportError;

  HbErrorReport({this.reportError}) {
    _initializeAsyncErrorZone();
    _initializeSyncErrorHandling();
  }

  /// Sets up a custom Zone to intercept uncaught asynchronous errors.
  /// 配置自定义 Zone 用于拦截未捕获的异步错误
  void _initializeAsyncErrorZone() {
    ZoneSpecification zoneSpecification = ZoneSpecification(
      handleUncaughtError: (
        Zone self,
        ZoneDelegate parent,
        Zone zone,
        Object error,
        StackTrace stackTrace,
      ) {
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
        _reportError(error, stackTrace);
      },
    );
    // Fork a new Zone for error handling
    // 创建一个新的 Zone 来处理错误
    errorHandlingZone = Zone.current.fork(specification: zoneSpecification);
  }

  /// Overrides Flutter's default synchronous error handling mechanism.
  /// 重写 Flutter 的默认同步错误处理机制
  void _initializeSyncErrorHandling() {
    FlutterExceptionHandler? originalHandler = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      originalHandler?.call(errorDetails);
      debugPrint(errorDetails.exception.toString());
      debugPrint(errorDetails.stack.toString());
      _reportError(errorDetails.exception, errorDetails.stack);
    };
  }

  /// Reports the given error and stack trace. Only reports in release mode.
  /// 上报错误信息和堆栈，仅在 Release 模式下执行
  void _reportError(Object error, StackTrace? stackTrace) {
    if (!kReleaseMode) return;
    // 处理你自己的上报逻辑
    reportError?.call(error, stackTrace);
  }
}
