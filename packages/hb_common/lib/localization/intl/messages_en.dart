// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class HbCommonLocalizationsImplEn extends HbCommonLocalizationsImpl {
  HbCommonLocalizationsImplEn([String locale = 'en']) : super(locale);

  @override
  String get confirm => 'Confirm';

  @override
  String get copySuccess => 'Copied successfully';

  @override
  String get noData => 'No Data';

  @override
  String totalTip(int count) {
    return 'No more, a total of $count records.';
  }

  @override
  String get loading => 'Loading...';

  @override
  String get pleaseSelect => 'Please Select';

  @override
  String get send => 'Send';

  @override
  String get confirmPasswordError => 'Confirm Password does not match Password';
}
