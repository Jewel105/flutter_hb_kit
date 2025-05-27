import 'package:flutter/material.dart';

import 'hb_router.dart';

/// Animation type for page transitions
/// 切换页面的动画
/// none: no animation
/// fromRight: page slides from right to left
/// fromLeft: page slides from left to right
/// fromBottom: page slides from bottom to top
/// zoomInOut: page zooms in and out
enum TransitionType { none, fromRight, fromLeft, fromBottom, zoomInOut }

class PageConfig {
  final Object? arguments;
  final TransitionType transitionType;
  const PageConfig({this.arguments, required this.transitionType});
}

class HbNav {
  /// push page
  /// Navigates to a new route in the application.
  ///
  /// [path] The route path to navigate to.
  /// [arguments] Optional data to pass to the new route.
  /// [transitionType] Animation type for the transition (defaults to sliding from right).
  ///
  /// Returns a Future that completes when the pushed route is popped.
  static Future<dynamic> push(
    String path, {
    Object? arguments,
    TransitionType transitionType = TransitionType.fromRight,
  }) {
    return Navigator.of(HbRouter.key.currentContext!).pushNamed(
      path,
      arguments: PageConfig(
        transitionType: transitionType,
        arguments: arguments,
      ),
    );
  }

  /// replace page
  /// Replaces the current route with a new one.
  ///
  /// [path] The route path to navigate to.
  /// [arguments] Optional data to pass to the new route.
  /// [transitionType] Animation type for the transition (defaults to sliding from right).
  ///
  /// Returns a Future that completes when the pushed route is popped.
  static Future<dynamic> replease(
    String path, {
    Object? arguments,
    TransitionType transitionType = TransitionType.fromRight,
  }) {
    return Navigator.of(HbRouter.key.currentContext!).pushReplacementNamed(
      path,
      arguments: PageConfig(
        transitionType: transitionType,
        arguments: arguments,
      ),
    );
  }

  /// Navigate to a page and clear the router stack
  /// 清空路由栈跳转，一般用于跳转首页这种情况
  ///
  /// [path] The route path to navigate to.
  /// [arguments] Optional data to pass to the new route.
  /// [transitionType] Animation type for the transition (defaults to sliding from right).
  ///
  /// Returns a Future that completes when the pushed route is popped.
  static Future<dynamic> switchTab(
    String path, {
    Object? arguments,
    TransitionType transitionType = TransitionType.none,
  }) {
    return Navigator.of(HbRouter.key.currentContext!).pushNamedAndRemoveUntil(
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
  ///
  /// [count] The number of pages to pop from the stack (default is 1).
  /// [arguments] Optional data to pass back to the previous route.
  ///
  /// Returns a Future that completes when the popped route is removed.
  static void back({int count = 1, Object? arguments}) {
    NavigatorState state = Navigator.of(HbRouter.key.currentContext!);
    while (count-- > 0) {
      if (state.canPop()) {
        if (HbRouter.history.isNotEmpty) HbRouter.history.removeLast();
        state = state..pop(arguments);
      }
    }
  }
}
