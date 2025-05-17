// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class HbQrLocalizationsImplZh extends HbQrLocalizationsImpl {
  HbQrLocalizationsImplZh([String locale = 'zh']) : super(locale);

  @override
  String get controllerNotReady => '控制器未准备好';

  @override
  String get permissionDenied => '权限被拒绝';

  @override
  String get scanUnsupported => '此设备不支持扫描';

  @override
  String get genericError => '通用错误';
}
