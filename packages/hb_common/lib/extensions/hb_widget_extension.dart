import 'package:flutter/material.dart';

extension HbWidgetExtension on Widget {
  Ink onInkTap(final GestureTapCallback? onTap, {BoxDecoration? decoration}) =>
      Ink(
        decoration: decoration,
        child: InkWell(
          onTap: onTap,
          borderRadius: decoration?.borderRadius is BorderRadius
              ? decoration!.borderRadius as BorderRadius
              : null,
          child: this,
        ),
      );

  MouseRegion onGestureTap(final GestureTapCallback? onTap) => MouseRegion(
        cursor: SystemMouseCursors.click, // Custom cursor
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: this,
        ),
      );

  Widget get left {
    return Align(alignment: Alignment.centerLeft, child: this);
  }

  Widget get right {
    return Align(alignment: Alignment.centerRight, child: this);
  }

  Widget get center {
    return Align(alignment: Alignment.center, child: this);
  }

  Widget get topLeft {
    return Align(alignment: Alignment.topLeft, child: this);
  }

  Widget get topRight {
    return Align(alignment: Alignment.topRight, child: this);
  }

  Widget get topCenter {
    return Align(alignment: Alignment.topCenter, child: this);
  }

  Widget get bottomCenter {
    return Align(alignment: Alignment.bottomCenter, child: this);
  }

  Widget get expanded {
    return Expanded(child: this);
  }

  Widget get toSliver => SliverToBoxAdapter(child: this);

  Widget p(double distance) =>
      Padding(padding: EdgeInsets.all(distance), child: this);

  Widget pt(double distance) =>
      Padding(padding: EdgeInsets.only(top: distance), child: this);
  Widget pl(double distance) =>
      Padding(padding: EdgeInsets.only(left: distance), child: this);
  Widget pr(double distance) =>
      Padding(padding: EdgeInsets.only(right: distance), child: this);
  Widget pb(double distance) =>
      Padding(padding: EdgeInsets.only(bottom: distance), child: this);
  Widget px(double distance) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: distance), child: this);
  Widget py(double distance) =>
      Padding(padding: EdgeInsets.symmetric(vertical: distance), child: this);
}
