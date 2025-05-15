import 'package:flutter/material.dart';

import 'models.dart';

class RouteBuilder {
  final Widget widget;
  final TransitionType? type;

  RouteBuilder({required this.widget, this.type});

  Route<dynamic> build() {
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
