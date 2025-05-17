// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class HbQrLocalizationsImplEn extends HbQrLocalizationsImpl {
  HbQrLocalizationsImplEn([String locale = 'en']) : super(locale);

  @override
  String get controllerNotReady => 'Controller not ready';

  @override
  String get permissionDenied => 'Permission denied';

  @override
  String get scanUnsupported => 'Scanning is unsupported on this device';

  @override
  String get genericError => 'Generic Error';
}
