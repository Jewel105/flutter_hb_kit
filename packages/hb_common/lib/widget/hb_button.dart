import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/hb_widget_extension.dart';

typedef FnCallBack = void Function();

class HbButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final FnCallBack? onTap;
  final double? height;
  final double? width;
  final double? radius;
  final Widget? preIcon;
  final bool collapseInput;
  final double? fontSize;
  final Widget? textWeight;

  const HbButton({
    super.key,
    required this.text,
    this.preIcon,
    this.bgColor,
    this.onTap,
    this.textColor,
    this.height,
    this.width,
    this.collapseInput = true,
    this.radius,
    this.fontSize,
    this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = bgColor ?? Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: height ?? 40.w,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: backgroundColor,
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 40.w),
          ),
        ),
        onPressed: onTap == null
            ? null
            : () {
                if (collapseInput) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
                onTap?.call();
              },
        child: textWeight ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                preIcon != null ? preIcon!.pr(8.w) : const SizedBox(),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: onTap == null
                        ? Theme.of(context).disabledColor
                        : textColor ?? Theme.of(context).colorScheme.onPrimary,
                    fontSize: fontSize ?? 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
