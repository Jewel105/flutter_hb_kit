import 'package:hb_chart/localization/hb_chart_localizations.dart';
import 'package:intl/intl.dart';

typedef FormatFn<T> = DateFormat Function([dynamic locale]);

enum HmsFormat { h, hm, hms }

enum DateType { minute, hour, day, month }

class DateFormatUtil {
  /// 日期格式化: 且会根据不同国家显示不同的样式
  /// 默认格式：10/06 12:56
  /// yMdFormat格式是：日期格式化，DateFormat.yMd，DateFormat.Md，DateFormat.yMMMMd
  /// hmsAddFormat: 添加时分秒的格式化样式
  /// time，可以是 DateTime类型，String，int类型为时间戳
  static String dateTimeFormat({
    required Object? time,
    FormatFn? yMdFormat,
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

    // 默认 10/06 12:56
    if (hmsAddFormat == null && yMdFormat == null) {
      return DateFormat.Md(
        HbChartLocalizations.current.localeName,
      ).add_Hm().format(dateTime);
    }

    // 只格式化时分秒
    if (yMdFormat == null) {
      switch (hmsAddFormat) {
        case HmsFormat.h:
          return DateFormat.H(
            HbChartLocalizations.current.localeName,
          ).format(dateTime);
        case HmsFormat.hm:
          return DateFormat.Hm(
            HbChartLocalizations.current.localeName,
          ).format(dateTime);
        default:
          return DateFormat.Hms(
            HbChartLocalizations.current.localeName,
          ).format(dateTime);
      }
    }

    // 只格式化年月日
    if (hmsAddFormat == null) {
      return yMdFormat(
        HbChartLocalizations.current.localeName,
      ).format(dateTime);
    }

    // 格式化年月日和时分秒
    DateFormat dateFormatTem = yMdFormat(
      HbChartLocalizations.current.localeName,
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

  static String format(Object? time, {DateType? type}) {
    switch (type) {
      case DateType.minute:
        return dateTimeFormat(time: time);
      case DateType.hour:
        return dateTimeFormat(time: time);
      case DateType.day:
        return dateTimeFormat(time: time, yMdFormat: DateFormat.yMd);
      case DateType.month:
        return dateTimeFormat(time: time, yMdFormat: DateFormat.yM);
      default:
        return dateTimeFormat(time: time);
    }
  }
}
