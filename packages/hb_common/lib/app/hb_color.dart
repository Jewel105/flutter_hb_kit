import 'dart:ui';

class HbColor {
  // 品牌色
  static Color mainDarkColor = Color(0xFF9FE870);
  static Color mainLightColor = Color(0xFF9FE870);

  // 背景色
  static Color bgWhite = Color(0xffFFFFFF);
  static Color bgBlack = Color(0xff1F1F1F);
  static Color bgGrey = Color(0xffF3F3F3); // 未激活背景色
  static Color bgGreyLight = Color(0xffF7F7F7);
  static Color bgGreyDark = Color(0xffECECEC);
  static Color bgError = Color(0xffFE5152);
  static Color bgSuccess = Color(0xff3FD300); // 涨，成功
  static Color bgWarn = Color(0xffD5A447); // 警告，提示
  static Color bgSuccessLight = Color.fromRGBO(63, 211, 0, 0.15); // 涨，成功
  static Color bgErrorLight = Color.fromRGBO(254, 81, 82, 0.15); // 涨，成功
  static Color bgWarnLight = Color.fromRGBO(255, 166, 0, 0.15); // 涨，成功

  // 文字色
  static Color textBlack = Color(0xff1F1F1F);
  static Color textWhite = Color(0xffFFFFFF);
  static Color textGrey = Color(0xff8F8F8F); // tip文字颜色
  static Color textGreyLight = Color(0xffCBCCCB); // 未激活文字色，输入框提示文字
  static Color textGreyDark = Color(0xff777777);
  static Color textSuccess = Color(0xff3FD300);
  static Color textError = Color(0xffFE5152);
  static Color textWarn = Color(0xffFFA600);

  // 边线色
  static Color lineGrey = Color(0xffF2F2F2);
  static Color lineBlack = Color(0xff000000);

  // 阴影色
  static Color shadowBlack = const Color(0x13000000);

  static setup({
    Color? mainDarkColor,
    Color? mainLightColor,
    Color? bgWhite,
    Color? bgBlack,
    Color? bgGrey,
    Color? bgGreyLight,
    Color? bgGreyDark,
    Color? bgError,
    Color? bgSuccess,
    Color? bgWarn,
    Color? bgSuccessLight,
    Color? bgErrorLight,
    Color? bgWarnLight,
    Color? textBlack,
    Color? textWhite,
    Color? textGrey,
    Color? textGreyLight,
    Color? textGreyDark,
    Color? textSuccess,
    Color? textError,
    Color? textWarn,
    Color? lineGrey,
    Color? lineBlack,
    Color? shadowBlack,
  }) {
    if (mainDarkColor != null) HbColor.mainDarkColor = mainDarkColor;
    if (mainLightColor != null) HbColor.mainLightColor = mainLightColor;
    if (bgWhite != null) HbColor.bgWhite = bgWhite;
    if (bgBlack != null) HbColor.bgBlack = bgBlack;
    if (bgGrey != null) HbColor.bgGrey = bgGrey;
    if (bgGreyLight != null) HbColor.bgGreyLight = bgGreyLight;
    if (bgGreyDark != null) HbColor.bgGreyDark = bgGreyDark;
    if (bgError != null) HbColor.bgError = bgError;
    if (bgSuccess != null) HbColor.bgSuccess = bgSuccess;
    if (bgWarn != null) HbColor.bgWarn = bgWarn;
    if (bgSuccessLight != null) HbColor.bgSuccessLight = bgSuccessLight;
    if (bgErrorLight != null) HbColor.bgErrorLight = bgErrorLight;
    if (bgWarnLight != null) HbColor.bgWarnLight = bgWarnLight;
    if (textBlack != null) HbColor.textBlack = textBlack;
    if (textWhite != null) HbColor.textWhite = textWhite;
    if (textGrey != null) HbColor.textGrey = textGrey;
    if (textGreyLight != null) HbColor.textGreyLight = textGreyLight;
    if (textGreyDark != null) HbColor.textGreyDark = textGreyDark;
    if (textSuccess != null) HbColor.textSuccess = textSuccess;
    if (textError != null) HbColor.textError = textError;
    if (textWarn != null) HbColor.textWarn = textWarn;
    if (lineGrey != null) HbColor.lineGrey = lineGrey;
    if (lineBlack != null) HbColor.lineBlack = lineBlack;
    if (shadowBlack != null) HbColor.shadowBlack = shadowBlack;
  }
}
