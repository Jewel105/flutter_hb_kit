import 'package:flutter/material.dart';
import 'package:hb_router/hb_router.dart';

import '../page/_page_404.dart';
import '_transition_models.dart';

typedef HbWidgetBuilder = Widget Function(Object? arguments);

class HbCurrentRoute {
  final String? name;
  final Object? arguments;
  final Widget widget;
  HbCurrentRoute({this.name, required this.arguments, required this.widget});
}

class HbRouter {
  // Navigate pages without context
  // 全局key，用于无context跳转的情况
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static HbCurrentRoute? get currentRoute {
    if (history.isEmpty) return null;
    return history.last;
  }

  static List<HbCurrentRoute> history = [];

  final Map<String, HbWidgetBuilder> routes;
  final HbMiddleware? middleware;
  const HbRouter(this.routes, {this.middleware});

  Route<dynamic>? generateRoute(RouteSettings settings) {
    PageConfig? pageConfig = settings.arguments as PageConfig?;
    var arguments = pageConfig?.arguments;
    Widget widget = routes[settings.name]?.call(arguments) ?? const Page404();
    // 执行中间件，目前只支持全局中间件
    widget = middleware?.execute(settings.name) ?? widget;
    // 记录当前路由
    var curRoute = HbCurrentRoute(
      name: settings.name,
      arguments: arguments,
      widget: widget,
    );
    history.add(curRoute);
    return _build(widget, pageConfig?.transitionType);
  }

  Route<dynamic> _build(Widget widget, TransitionType? type) {
    switch (type) {
      case TransitionType.none:
        return NoAnimationPageRoute<Object?>(builder: (context) => widget);
      case TransitionType.fromRight:
        return MaterialPageRoute<Object?>(builder: (context) => widget);
      case TransitionType.fromLeft:
        return SlideFromLeftPageRoute<Object?>(builder: (context) => widget);
      case TransitionType.fromBottom:
        return FadeUpwardsPageRoute<Object?>(builder: (context) => widget);
      case TransitionType.zoomInOut:
        return ZoomPageRoute<Object?>(builder: (context) => widget);
      default:
        return MaterialPageRoute<Object?>(builder: (context) => widget);
    }
  }
}
