import 'package:flutter/material.dart';

import './models.dart';

class Nav {
  // Navigate pages without context
  // 全局key，用于无context跳转的情况
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// push page
  static Future<dynamic> push(
    String path, {
    Object? arguments,
    TransitionType transitionType = TransitionType.fromRight,
  }) {
    return Navigator.of(navigatorKey.currentContext!).pushNamed(
      path,
      arguments: PageConfig(
        transitionType: transitionType,
        arguments: arguments,
      ),
    );
  }

  /// replace page
  static Future<dynamic> replease(
    String path, {
    Object? arguments,
    TransitionType transitionType = TransitionType.fromRight,
  }) {
    return Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
      path,
      arguments: PageConfig(
        transitionType: transitionType,
        arguments: arguments,
      ),
    );
  }

  /// Navigate to a page and clear the router stack
  /// 清空路由栈跳转，一般用于跳转首页这种情况
  static Future<dynamic> switchTab(
    String path, {
    Object? arguments,
    TransitionType transitionType = TransitionType.none,
  }) {
    return Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
      path,
      (_) => false,
      arguments: PageConfig(
        transitionType: transitionType,
        arguments: arguments,
      ),
    );
  }

  /// back to the previous page
  /// 无context返回,并指定路由返回多少层，默认返回上一页面, 返回带参数params
  static void back({int count = 1, Object? arguments}) {
    NavigatorState state = Navigator.of(navigatorKey.currentContext!);
    while (count-- > 0) {
      if (state.canPop()) state = state..pop(arguments);
    }
  }
}
