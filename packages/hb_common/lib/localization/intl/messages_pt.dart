// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class HbCommonLocalizationsImplPt extends HbCommonLocalizationsImpl {
  HbCommonLocalizationsImplPt([String locale = 'pt']) : super(locale);

  @override
  String get confirm => 'Confirmar';

  @override
  String get copySuccess => 'Copiado com sucesso';

  @override
  String get noData => 'Sem Dados';

  @override
  String totalTip(int count) {
    return 'Sem mais registros, total de $count registros.';
  }

  @override
  String get loading => 'Carregando...';

  @override
  String get pleaseSelect => 'Selecione';

  @override
  String get send => 'Enviar';

  @override
  String get confirmPasswordError => 'Confirmação de senha não corresponde';
}
