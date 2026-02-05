import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hb_router/hb_router.dart';

typedef BackCallback = void Function();

/// Customized navigation bar
/// 自定义导航栏
class HbAppBar extends AppBar {
  HbAppBar({
    super.key,
    super.actions, // Actions on the right side of the AppBar (来自父类的右侧操作按钮组件)
    bool? isCenterTitle, // Whether the title is centered (default: true)
    String? titleName, // Title text (标题文本)
    Color? bgColor,
    TextStyle? titleStyle,
    Widget? leading, // Widget for the leading area, typically a back button
    Widget? titleWidget, // Custom widget for the title (自定义的标题组件)
    BackCallback? onBack,
    bool showBackButton = true, // Whether to show the back button (默认显示返回按钮)
  }) : super(
          surfaceTintColor: bgColor,
          toolbarHeight: 44.w,
          backgroundColor: bgColor,
          title: titleName == null ? titleWidget : Text(titleName),
          titleTextStyle: titleStyle,
          leading: showBackButton
              ? leading ??
                  InkWell(
                    onTap: () {
                      if (onBack != null) {
                        onBack();
                      } else {
                        HbNav.back();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child:
                          Icon(Icons.arrow_back_ios, color: titleStyle?.color),
                    ),
                  )
              : null,
          centerTitle: isCenterTitle,
        );
}
