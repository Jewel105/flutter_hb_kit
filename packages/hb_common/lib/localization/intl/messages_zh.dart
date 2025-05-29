// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class HbCommonLocalizationsImplZh extends HbCommonLocalizationsImpl {
  HbCommonLocalizationsImplZh([String locale = 'zh']) : super(locale);

  @override
  String get confirm => '确定';

  @override
  String get copySuccess => '复制成功';

  @override
  String get noData => '暂无数据';

  @override
  String totalTip(int count) {
    return '没有更多了，共 $count 条记录';
  }

  @override
  String get loading => '加载中...';

  @override
  String get pleaseSelect => '请选择';

  @override
  String get send => '发送';

  @override
  String get confirmPasswordError => '确认密码不匹配';
}
