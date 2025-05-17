// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class HbQrLocalizationsImplPt extends HbQrLocalizationsImpl {
  HbQrLocalizationsImplPt([String locale = 'pt']) : super(locale);

  @override
  String get controllerNotReady => 'Controlador não está pronto';

  @override
  String get permissionDenied => 'Permissão negada';

  @override
  String get scanUnsupported => 'A digitalização não é suportada neste dispositivo';

  @override
  String get genericError => 'Erro genérico';
}
