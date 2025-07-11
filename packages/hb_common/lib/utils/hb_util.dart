import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../localization/hb_common_localizations.dart';
import 'hb_dialog.dart';

typedef FormatFn<T> = DateFormat Function([dynamic locale]);

enum HmsFormat { h, hm, hms }

class HbUtil {
  /// 日期格式化: 且会根据不同国家显示不同的样式
  /// 默认格式：2023/10/06 12:56:34
  /// customFormat格式是：日期格式化，DateFormat.yMd，DateFormat.Md，DateFormat.yMMMMd
  /// hmsAddFormat: 添加时分秒的格式化样式
  /// time，可以是 DateTime类型，String，int类型为时间戳
  static String dateTimeFormat(
    BuildContext context, {
    required Object? time,
    FormatFn? customFormat,
    HmsFormat? hmsAddFormat,
  }) {
    if (time == null) return '';
    if (time == '') return '';
    DateTime dateTime = DateTime.now();
    if (time is DateTime) {
      dateTime = time;
    } else if (time is String) {
      dateTime = DateTime.parse(time).toLocal();
    } else if (time is int) {
      if (time.toString().length == 10) {
        time = time * 1000;
      }
      dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    }

    // 默认 2023/10/06 12:56:34
    if (hmsAddFormat == null && customFormat == null) {
      return DateFormat.yMd(
        HbCommonLocalizations.of(context).localeName,
      ).add_Hms().format(dateTime);
    }

    // 只格式化时分秒
    if (customFormat == null) {
      switch (hmsAddFormat) {
        case HmsFormat.h:
          return DateFormat.H(
            HbCommonLocalizations.of(context).localeName,
          ).format(dateTime);
        case HmsFormat.hm:
          return DateFormat.Hm(
            HbCommonLocalizations.of(context).localeName,
          ).format(dateTime);
        default:
          return DateFormat.Hms(
            HbCommonLocalizations.of(context).localeName,
          ).format(dateTime);
      }
    }

    // 只格式化年月日
    if (hmsAddFormat == null) {
      return customFormat(
        HbCommonLocalizations.of(context).localeName,
      ).format(dateTime);
    }

    // 格式化年月日和时分秒
    DateFormat dateFormatTem = customFormat(
      HbCommonLocalizations.of(context).localeName,
    );

    switch (hmsAddFormat) {
      case HmsFormat.h:
        return dateFormatTem.add_H().format(dateTime);
      case HmsFormat.hm:
        return dateFormatTem.add_Hm().format(dateTime);
      default:
        return dateFormatTem.add_Hms().format(dateTime);
    }
  }

  /// 判断两个 DateTime 是否是同一天
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// 将地址缩短为前几位和后几位，中间用点号替代
  /// 返回格式 0x912C...9E6548
  /// [address] 需要格式化的地址
  /// [slot] 中间替代符号，默认为点号
  /// [digit] 前后保留的位数，默认为6
  static String addressFormat(
    String? address, {
    String slot = '.',
    int digit = 6,
  }) {
    if (address == null || address.isEmpty) return '--';
    if (address.length < digit) return address;
    String str = '';
    str =
        '${address.substring(0, digit)}${slot * 4}${address.substring(address.length - digit, address.length)}';
    return str;
  }

  /// 取小数点后几位-截断保留
  /// @param num 数值
  /// @param location 保留几位小数
  /// @param needThousands 是否需要千位分割。默认需要
  /// @param remainAvailable 是否计算有效小数。默认不计算，比如0.0003，小数位是2位，true返回0.0003，false返回0
  /// @param  showBracket 小数多0是否展示括号
  static String formatNum(
    String? num, {
    int digit = 6,
    bool needThousands = true,
    remainAvailable = false,
    showBracket = false,
  }) {
    if (num == null || num.isEmpty) return '0.00';
    List<String> list = num.split(".");
    String integerStr = list[0];
    // 千分位分割
    integerStr = needThousands ? thousands(integerStr) : integerStr;

    if (digit == 0) return integerStr; // 不保留小数

    // 无小数，补充小数
    if (list.length == 1) {
      // String decimalStr = '0' * digit;
      return integerStr;
    }

    // 有小数的情况
    String decimalStr = list[1];

    // 整数部分不为0，或者不计算有效小数
    if (integerStr.replaceAll('0', '').isNotEmpty || !remainAvailable) {
      integerStr = needThousands ? thousands(integerStr) : integerStr;
      if (decimalStr.length > digit) {
        decimalStr = decimalStr.substring(0, digit); // 保留小数位
        // decimalStr = decimalStr.replaceAll(RegExp(r'0*$'), ''); // 去掉尾部多余的0
        return '$integerStr.$decimalStr';
      }
    }

    // 整数部分为0
    integerStr = needThousands ? thousands(integerStr) : integerStr;

    // 获取小数位数前面的0
    String leadingZero = RegExp(r'^0*').firstMatch(decimalStr)![0] ?? '';

    if (leadingZero.length >= 5 && showBracket) {
      // 前面小数位大于5，处理为 0{3} 的格式
      leadingZero = '0{${leadingZero.length - 1}}';
    }

    decimalStr = decimalStr.replaceAll(RegExp(r'^0*'), ''); // 有效数字
    if (decimalStr.length > digit) {
      decimalStr = decimalStr.substring(0, digit);
      decimalStr = decimalStr.replaceAll(RegExp(r'0*$'), ''); // 去掉尾部多余的0
    }
    return '$integerStr.$leadingZero$decimalStr';
  }

  /// 整数增加千位分割符，接收一个整数字符串参数
  static String thousands(String integerStr) {
    if (integerStr.isEmpty) return '0';
    RegExp regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return integerStr.replaceAllMapped(
      regex,
      (Match match) => '${match.group(1)},',
    );
  }

  /// 是否为正
  static bool isPositive(String? num) {
    if (num == null || num.isEmpty) return true;
    return double.parse(num) >= 0;
  }

  /// 增加百分号,并加上正负符号
  /// needOperate 是否需要加上正负号，默认不需要
  static String addPercent(String? num, {bool needOperate = false}) {
    if (num == null || num.isEmpty) return '+0.00%';
    if (isPositive(num) && needOperate) {
      return '+${(double.parse(num) * 100).toStringAsFixed(2)}%';
    } else {
      return '${(double.parse(num) * 100).toStringAsFixed(2)}%';
    }
  }

  /// 交易量科学计数
  static String toScientific(String? num) {
    if (num == null || num.isEmpty) return '0.00'; // 如果字符串为空，则返回'0'
    double number = double.tryParse(num) ?? 0;
    String formattedString = number.toStringAsFixed(2);
    if (number >= 1e12) {
      formattedString = '${(number / 1e12).toStringAsFixed(2)}T';
    } else if (number >= 1e9) {
      formattedString = '${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      formattedString = '${(number / 1e6).toStringAsFixed(2)}M';
    } else if (number >= 1e3) {
      formattedString = '${(number / 1e3).toStringAsFixed(2)}k';
    }
    return formattedString;
  }

  /// 链上错误消息格式化
  static String web3ErrorFormat(String input) {
    String res = '';
    try {
      RegExp regex = RegExp(r'"([^"]*)"');
      final match = regex.firstMatch(input);
      if (match != null) {
        res = match.group(1)!;
      } else {
        res = input;
      }
    } catch (e) {
      res = input;
    }
    return res;
  }

  // 处理ETH ethereum:0x格式地址
  static dynamic formatEthAddress(dynamic address) {
    if (address is String && address.startsWith('ethereum')) {
      address = address.substring(9);
    }
    return address;
  }

  /// 生成随机字符串
  static String generateRandomString({int length = 8}) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString =
        List.generate(
          length,
          (index) => availableChars[random.nextInt(availableChars.length)],
        ).join();
    return randomString;
  }

  /// 复制字符串到剪切板
  static Future<void> copy(String? text) async {
    await Clipboard.setData(ClipboardData(text: text ?? ''));
    HbDialog.successToast(HbCommonLocalizations.current.copySuccess);
  }
}
