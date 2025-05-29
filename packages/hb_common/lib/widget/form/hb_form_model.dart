import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class HbSelectItemModel<T> {
  String get icon;
  String get code;
  String get description;
}

abstract class HbFormWidget<T> extends StatefulWidget {
  const HbFormWidget({super.key});

  /// 子类必须实现：返回对应表单控件
  void setFormValue(Map<String, dynamic>? value);
}

// 单选的controller
class HbRadioController {
  ValueNotifier<int> curIndex = ValueNotifier(-1);
  ValueNotifier<HbSelectItemModel?> selectItem = ValueNotifier(null);
  void clear() {
    curIndex.value = -1;
    selectItem.value = null;
  }
}

enum HbValidatorType { require, confirmPass, password, code, email }

typedef HbValidatorFnType = String? Function(String?)?;

class HbFormData {
  final String? name;
  final bool show;
  final GlobalKey? inputKey; // 输入框的key
  final GlobalKey? preKey; // 需要校验的上一个输入框的key，发送验证码会用到
  final String? label;
  final String? email;
  final Widget? rightLabel;
  final Widget? labelWeight;
  // 当前文本框的controller
  final TextEditingController? controller;
  // 上一个文本框的controller，用于确认密码校验与上一个密码输入框的密码是否相同
  final TextEditingController? preController;
  final String? initialValue; // 初始值
  final bool autofocus; // 自动获取焦点
  final bool enabled; // 是否可用
  final bool? readOnly; // 是否只读
  final String? hintText; // 提示暗字
  final String? uploadTip; // 上传图片右边的提示
  final Widget? suffix; // 尾部组件
  final Widget? prefix; // 前缀组件
  final Widget? defaultImage; // 默认显示图片
  final Widget? customWidget; // 自定义weight，与type：custom搭配使用
  final int? maxLength; // 输入框长度显示
  final int? maxLines; // 输入框行数限制
  // 输入框类型，控制校验数据，尾部图标
  // require(默认必须)，email，password,code,confirmPass（确认密码）
  final HbValidatorType validatorType;
  // 需要自定义校验
  final HbValidatorFnType? validator;
  // 输入框按钮类型：
  final TextInputAction? textInputAction;
  // 键盘类型
  final TextInputType? keyboardType;
  // 输入框值变化
  final ValueChanged<String>? onChanged;
  // selected值变化
  final ValueChanged<int>? onSelected;
  // 输入框点击完成
  final ValueChanged<String>? onFieldSubmitted;
  // 输入框被点击
  final GestureTapCallback? onTap;
  final GestureTapCallback? onBlur;
  // 底部选框的items
  final List<HbSelectItemModel> selectItems;
  // 底部弹窗或单选框的controller
  final HbRadioController? radioController;
  final List<TextInputFormatter>? inputFormatters;
  // 选项是否显示icon
  final bool showIcon;
  // 选项是否显示描述
  final bool showDescription;
  // 发送邮件
  final Function? sendCode;

  HbFormData({
    this.name,
    this.show = true,
    this.inputKey,
    this.customWidget,
    this.preKey,
    this.label,
    this.labelWeight,
    this.rightLabel,
    this.initialValue,
    this.controller,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly,
    this.showIcon = true,
    this.showDescription = true,
    this.hintText,
    this.uploadTip,
    this.validatorType = HbValidatorType.require,
    this.preController,
    this.email,
    this.suffix,
    this.prefix,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.onSelected,
    this.onFieldSubmitted,
    this.radioController,
    this.onTap,
    this.onBlur,
    this.selectItems = const [],
    this.inputFormatters,
    this.defaultImage,
    this.maxLines,
    this.maxLength,
    this.sendCode,
  });
}

class HbFormController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final Map<String, dynamic> value = {};
  HbFormController();
  void clear() {
    value.clear();
  }

  bool validate() {
    return key.currentState?.validate() ?? false;
  }
}
