import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hb_common/hb_common.dart';
import 'package:hb_router/hb_router.dart';

import '../localization/hb_common_localizations.dart';

typedef CancelFunc = void Function();

class HbDialog {
  static setup() {}

  static const String _defaultDialogIcon = 'assets/svg/icon_tip.svg';

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
                            HbNav.back(arguments: false);
                          },
                          child: Icon(Icons.close, size: 18.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.w),
                  HbIcon(
                    icon: icon ?? _defaultDialogIcon,
                    width: 48.w,
                    height: 48.w,
                  ),
                  SizedBox(height: 12.w),
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
                              textName: cancelText ?? 'Cancel',
                              onTap: () {
                                HbNav.back(arguments: false);
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
                            textName:
                                confirmText ??
                                HbCommonLocalizations.current.confirm,
                            onTap: () {
                              HbNav.back(arguments: true);
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
  static CancelFunc showLoading() {
    return BotToast.showCustomLoading(
      backgroundColor: HbColor.shadowBlack,
      toastBuilder: (CancelFunc cancel) {
        return SpinKitChasingDots(color: HbColor.mainDarkColor);
      },
    );
  }

  /// 关闭loading
  static closeAllLoading() {
    BotToast.closeAllLoading();
  }
}
