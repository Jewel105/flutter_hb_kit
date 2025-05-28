import 'package:decimal/decimal.dart';
import 'package:flutter/services.dart';

/// 输入数字限制
/// [digit] 最多可以输入的小数位数
/// [max] 输入的数字不得超过此值
class HbAmountFormatter extends FilteringTextInputFormatter {
  final int digit;
  final num max;

  HbAmountFormatter({
    this.digit = 18,
    this.max = double.infinity,
    bool allow = true,
  }) : super(RegExp('[0-9.,]'), allow: allow);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final handlerValue = super.formatEditUpdate(oldValue, newValue);
    String value = handlerValue.text.replaceAll(',', '.');
    int selectionIndex = handlerValue.selection.end;

    ///如果输入框内容为.直接将输入框赋值为0.
    if (value == '.') {
      value = '0.';
      selectionIndex++;
    }

    ///判断小数位数
    if (_getValueDigit(value) > digit || _pointCount(value) > 1) {
      value = oldValue.text;
      selectionIndex = oldValue.text.length;
    }
    // 判断金额大小
    if ((double.tryParse(value) ?? 0) > max) {
      value = Decimal.parse(max.toString()).toString();
      selectionIndex = value.length;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  ///输入多个小数点的情况
  int _pointCount(String value) {
    int count = 0;
    value.split('').forEach((e) {
      if (e == '.') {
        count++;
      }
    });
    return count;
  }

  ///获取目前的小数位数
  int _getValueDigit(String value) {
    if (value.contains('.')) return value.split('.')[1].length;
    return -1;
  }
}
