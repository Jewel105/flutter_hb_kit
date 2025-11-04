// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class HbChartLocalizationsImplEn extends HbChartLocalizationsImpl {
  HbChartLocalizationsImplEn([String locale = 'en']) : super(locale);

  @override
  String dayFormat(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get date => 'Date';

  @override
  String get open => 'Open';

  @override
  String get high => 'High';

  @override
  String get low => 'Low';

  @override
  String get close => 'Close';

  @override
  String get changeAmount => 'Change';

  @override
  String get change => 'Change%';

  @override
  String get amount => 'Amount';
}
