import 'package:flutter/widgets.dart';

/// 路由中间件的抽象基类
abstract class HbMiddleware {
  const HbMiddleware();

  /// 执行中间件处理逻辑
  Widget? execute(String? route);
}
