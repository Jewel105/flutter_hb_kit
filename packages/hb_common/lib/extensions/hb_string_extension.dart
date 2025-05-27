import 'dart:ui';

import 'package:hb_common/utils/hb_util.dart';

extension HbUtilExtension on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty || this == '';

  /// 格式化数字
  /// 小数位2位
  String get formatNum {
    return HbUtil.formatNum(
      this,
      digit: 2,
      needThousands: true,
      remainAvailable: false,
      showBracket: false,
    );
  }

  /// 格式化数字，不使用千分位
  /// 小数位2位
  String get formatRawNum {
    return HbUtil.formatNum(
      this,
      digit: 2,
      needThousands: false,
      remainAvailable: false,
      showBracket: false,
    );
  }

  // 格式化字符串
  String get addressFormat {
    return HbUtil.addressFormat(this);
  }

  /// 给数字加上加减号,并格式化
  /// 默认保留2位小数位
  String get amountFormat {
    var isPositive = HbUtil.isPositive(this);
    if (isPositive) {
      if (this == '0') {
        return HbUtil.formatNum(
          this,
          digit: 2,
          needThousands: true,
          remainAvailable: false,
          showBracket: false,
        );
      }
      return '+${HbUtil.formatNum(this, digit: 2, needThousands: true, remainAvailable: false, showBracket: false)}';
    } else {
      return HbUtil.formatNum(
        this,
        digit: 2,
        needThousands: true,
        remainAvailable: false,
        showBracket: false,
      );
    }
  }

  /// 自定义小数位格式化数字
  String formatNumDigit(int digit) {
    return HbUtil.formatNum(
      this,
      digit: digit,
      needThousands: true,
      remainAvailable: false,
      showBracket: false,
    );
  }

  /// 自定义小数位格式化数字，不包含千分位
  String formatRawNumDigit(int digit) {
    return HbUtil.formatNum(
      this,
      digit: digit,
      needThousands: false,
      remainAvailable: false,
      showBracket: false,
    );
  }
}

extension HbUtilNumExtension on num? {
  /// 格式化数字
  /// 小数位2位
  String get formatNum {
    return HbUtil.formatNum(
      toString(),
      digit: 2,
      needThousands: true,
      remainAvailable: false,
      showBracket: false,
    );
  }

  /// 格式化数字，不使用千分位
  /// 小数位2位
  String get formatRawNum {
    return HbUtil.formatNum(
      toString(),
      digit: 2,
      needThousands: false,
      remainAvailable: false,
      showBracket: false,
    );
  }

  /// 给数字加上加减号,并格式化
  /// 默认保留2位小数位
  String get amountFormat {
    var isPositive = HbUtil.isPositive(toString());
    if (isPositive) {
      if (toString() == '0') {
        return HbUtil.formatNum(
          toString(),
          digit: 2,
          needThousands: true,
          remainAvailable: false,
          showBracket: false,
        );
      }
      return '+${HbUtil.formatNum(toString(), digit: 2, needThousands: true, remainAvailable: false, showBracket: false)}';
    } else {
      return HbUtil.formatNum(
        toString(),
        digit: 2,
        needThousands: true,
        remainAvailable: false,
        showBracket: false,
      );
    }
  }

  /// 自定义小数位格式化数字
  String formatNumDigit(int digit) {
    return HbUtil.formatNum(
      toString(),
      digit: digit,
      needThousands: true,
      remainAvailable: false,
      showBracket: false,
    );
  }

  /// 自定义小数位格式化数字，不包含千分位
  String formatRawNumDigit(int digit) {
    return HbUtil.formatNum(
      toString(),
      digit: digit,
      needThousands: false,
      remainAvailable: false,
      showBracket: false,
    );
  }
}

extension HbUtilStringExtension on String {
  Color get toColor {
    return Color(int.parse(replaceAll("#", ""), radix: 16) + 0xFF000000);
  }
}
