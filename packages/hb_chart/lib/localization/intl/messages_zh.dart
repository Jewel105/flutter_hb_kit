// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class HbChartLocalizationsImplZh extends HbChartLocalizationsImpl {
  HbChartLocalizationsImplZh([String locale = 'zh']) : super(locale);

  @override
  String dayFormat(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get date => '日期';

  @override
  String get open => '开盘';

  @override
  String get high => '最高';

  @override
  String get low => '最低';

  @override
  String get close => '收盘';

  @override
  String get changeAmount => '涨跌额';

  @override
  String get change => '涨跌幅';

  @override
  String get amount => '成交额';
}
