import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hb_router/hb_router.dart';

import '../hb_common.dart';

typedef CancelFunc = void Function();

class HbDialog {
  // 初始化
  static TransitionBuilder setup({String? defaultDialogIcon}) {
    if (defaultDialogIcon != null) {
      _defaultDialogIcon = defaultDialogIcon;
    }
    return BotToastInit();
  }

  // navigatorObservers
  static NavigatorObserver navigatorObservers = BotToastNavigatorObserver();

  static String _defaultDialogIcon = '';

  /// 提示框
  static Future<bool?> openDialog({
    String content = '--',
    String? confirmText,
    String? cancelText,
    String? titleText,
    String? icon,
  }) {
    return showDialog(
      context: HbRouter.key.currentContext!,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(8.w),
            child: Container(
              width: 300.w,
              padding: EdgeInsets.symmetric(vertical: 16.w),
              decoration: HbStyle.toBoxR8(color: HbColor.bgWhite),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          titleText ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Positioned(
                        right: 16.w,
                        child: GestureDetector(
                          onTap: () {
                            HbNav.pop(arguments: false);
                          },
                          child: Icon(Icons.close, size: 18.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.w),
                  Visibility(
                    visible: (icon ?? _defaultDialogIcon).isNotEmpty,
                    child: HbIcon(
                      icon: icon ?? _defaultDialogIcon,
                      width: 48.w,
                      height: 48.w,
                    ).pb(12.w),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 16 / 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: <Widget>[
                        Visibility(
                          visible: cancelText != null,
                          child: Expanded(
                            child: HbButton(
                              height: 36.w,
                              bgColor: HbColor.bgGrey,
                              text: cancelText ?? 'Cancel',
                              onTap: () {
                                HbNav.pop(arguments: false);
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: cancelText != null,
                          child: SizedBox(width: 8.w),
                        ),
                        Expanded(
                          child: HbButton(
                            height: 36.w,
                            text:
                                confirmText ??
                                HbCommonLocalizations.current.confirm,
                            onTap: () {
                              HbNav.pop(arguments: true);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// loading
  static CancelFunc showLoading({Widget? loadingWidget}) {
    return BotToast.showCustomLoading(
      backgroundColor: HbColor.shadowBlack,
      toastBuilder: (CancelFunc cancel) {
        return loadingWidget ??
            SpinKitFadingCircle(color: HbColor.mainDarkColor);
      },
    );
  }

  /// 关闭loading
  static closeAllLoading() {
    BotToast.closeAllLoading();
  }

  /// 普通toast
  static void _showToast(String msg, {Widget? preIcon}) {
    BotToast.showCustomText(
      duration: const Duration(milliseconds: 2500),
      toastBuilder: (void Function() cancelFunc) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
          decoration: HbStyle.toBoxR8(color: HbColor.textBlack),
          child: Row(
            children: [
              Visibility(
                visible: preIcon != null,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: preIcon,
                ),
              ),
              Expanded(
                child: Text(
                  msg,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 错误toast
  static void errorToast(String msg) {
    _showToast(
      msg,
      preIcon: Icon(Icons.cancel_rounded, color: HbColor.textError, size: 18.w),
    );
  }

  /// 警告toast
  static void warnToast(String msg) {
    _showToast(
      msg,
      preIcon: Icon(Icons.error_rounded, color: HbColor.textWarn, size: 18.w),
    );
  }

  /// 成功toast
  static void successToast(String msg) {
    _showToast(
      msg,
      preIcon: Icon(
        Icons.check_circle_rounded,
        color: HbColor.textSuccess,
        size: 18.w,
      ),
    );
  }

  /// 顶部下拉显示的通知
  static void notify({
    required String title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    Widget? leading,
    Color backgroundColor = Colors.white,
    Duration duration = const Duration(seconds: 4),
    void Function()? onTap,
  }) {
    BotToast.showNotification(
      title: (context) {
        return Text(title, style: titleStyle);
      },
      subtitle:
          subtitle == null
              ? null
              : (context) {
                return Text(subtitle, style: subtitleStyle);
              },
      leading:
          leading == null
              ? null
              : (context) {
                return leading;
              },
      backgroundColor: backgroundColor,
      duration: duration,
      onTap: onTap,
    );
  }
}
