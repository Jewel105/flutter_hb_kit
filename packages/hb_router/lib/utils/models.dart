import 'package:flutter/material.dart';

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

/// no-animation page
/// 不使用页面切换动画
class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

/// Page from top to bottom fade in
/// 页面从下向上淡入
class FadeUpwardsPageRoute<T> extends MaterialPageRoute<T> {
  FadeUpwardsPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return const FadeUpwardsPageTransitionsBuilder().buildTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

/// Page zoom in and out
/// 页面缩放展开
class ZoomPageRoute<T> extends MaterialPageRoute<T> {
  ZoomPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return const ZoomPageTransitionsBuilder().buildTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

/// Page from left to right
/// 页面从左到右展开
class SlideFromLeftPageRoute<T> extends MaterialPageRoute<T> {
  SlideFromLeftPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return const SlideFromLeftPageTransitionsBuilder().buildTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

/// Page transitions builder for left-to-right
/// 页面从左向右展开
class SlideFromLeftPageTransitionsBuilder extends PageTransitionsBuilder {
  const SlideFromLeftPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Animation<Offset> slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.ease));
    return SlideTransition(position: slideAnimation, child: child);
  }
}
