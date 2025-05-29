// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class HbCommonLocalizationsImplHi extends HbCommonLocalizationsImpl {
  HbCommonLocalizationsImplHi([String locale = 'hi']) : super(locale);

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get copySuccess => 'सफलतापूर्वक कॉपी किया गया';

  @override
  String get noData => 'कोई डेटा नहीं';

  @override
  String totalTip(int count) {
    return 'अधिक नहीं, कुल $count रिकॉर्ड';
  }

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get pleaseSelect => 'कृपया चुनें';

  @override
  String get send => 'भेजें';

  @override
  String get confirmPasswordError => 'पासवर्ड पुष्टि मेल नहीं खाती';
}
