import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../app/index.dart';
import '../../extensions/index.dart';
import '../../localization/hb_common_localizations.dart';
import '../../utils/hb_crypto.dart';
import '../index.dart';

// 输入框
// ignore: must_be_immutable
class HbInput extends HbFormWidget {
  final HbFormData data;
  Map<String, dynamic>? formValue;

  HbInput.fromData(this.data, {super.key});

  HbInput({
    super.key,
    String? name,
    bool show = true,
    GlobalKey? inputKey, // 输入框的key
    GlobalKey? preKey, // 需要校验的上一个输入框的key，发送验证码会用到
    String? label,
    String? email,
    Widget? rightLabel,
    Widget? labelWeight,
    // 当前文本框的controller
    TextEditingController? controller,
    // 上一个文本框的controller，用于确认密码校验与上一个密码输入框的密码是否相同
    TextEditingController? preController,
    String? initialValue, // 初始值
    bool autofocus = false, // 自动获取焦点
    bool enabled = true, // 是否可用
    bool? readOnly, // 是否只读
    String? hintText, // 提示暗字
    String? uploadTip, // 上传图片右边的提示
    Widget? suffix, // 尾部组件
    Widget? prefix, // 前缀组件
    Widget? defaultImage, // 默认显示图片
    Widget? customWidget, // 自定义weight，与type：custom搭配使用
    int? maxLength, // 输入框长度显示
    int? maxLines, // 输入框行数限制
    // 输入框类型，控制校验数据，尾部图标
    // require(默认必须)，email，password,code,confirmPass（确认密码）
    HbValidatorType validatorType = HbValidatorType.require,
    // 需要自定义校验
    HbValidatorFnType? validator,
    // 输入框按钮类型：
    TextInputAction? textInputAction,
    // 键盘类型
    TextInputType? keyboardType,
    // 输入框值变化
    ValueChanged<String>? onChanged,
    // selected值变化
    ValueChanged<int>? onSelected,
    // 输入框点击完成
    ValueChanged<String>? onFieldSubmitted,
    // 输入框被点击
    GestureTapCallback? onTap,
    GestureTapCallback? onBlur,
    // 底部选框的items
    List<HbSelectItemModel> selectItems = const [],
    // 底部弹窗或单选框的controller
    HbRadioController? radioController,
    List<TextInputFormatter>? inputFormatters,
    // 选项是否显示icon
    bool showIcon = true,
    // 选项是否显示描述
    bool showDescription = true,
    // 发送邮件
    Function? sendCode,
  }) : data = HbFormData(
         name: name,
         show: show,
         inputKey: inputKey,
         preKey: preKey,
         label: label,
         email: email,
         rightLabel: rightLabel,
         labelWeight: labelWeight,
         controller: controller,
         preController: preController,
         initialValue: initialValue,
         autofocus: autofocus,
         enabled: enabled,
         readOnly: readOnly,
         hintText: hintText,
         uploadTip: uploadTip,
         suffix: suffix,
         prefix: prefix,
         defaultImage: defaultImage,
         customWidget: customWidget,
         maxLength: maxLength,
         maxLines: maxLines,
         validatorType: validatorType,
         validator: validator,
         textInputAction: textInputAction,
         keyboardType: keyboardType,
         onChanged: onChanged,
         onSelected: onSelected,
         onFieldSubmitted: onFieldSubmitted,
         onTap: onTap,
         onBlur: onBlur,
         selectItems: selectItems,
         radioController: radioController,
         inputFormatters: inputFormatters,
         showIcon: showIcon,
         showDescription: showDescription,
         sendCode: sendCode,
       );

  @override
  State<HbInput> createState() => HbInputState();

  @override
  setFormValue(Map<String, dynamic>? value) {
    if (value != null && data.name != null && data.name!.isNotEmpty) {
      formValue = value;
    }
  }
}

class HbInputState extends State<HbInput> {
  bool _hidePassword = false;
  late final TextEditingController _controller;
  final StreamController<int> _streamController = StreamController();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _controller = widget.data.controller ?? TextEditingController();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.data.onBlur?.call();
      }
    });
    // 密码框需要隐藏
    _hidePassword =
        widget.data.validatorType == HbValidatorType.confirmPass ||
        widget.data.validatorType == HbValidatorType.password;
    // 初始化值
    _setName(widget.data.initialValue ?? _controller.text);
    _controller.addListener(() {
      _setName(_controller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    if (widget.data.controller == null) {
      _controller.dispose();
    }
  }

  // 点击发送验证码
  void _sendCode() async {
    // 校验邮箱或者手机号
    if (widget.data.preKey == null ||
        (widget.data.preKey!.currentState as FormFieldState).validate()) {
      await widget.data.sendCode?.call();
      // 开启计时
      int count = 60;
      while (count > 0) {
        await Future.delayed(const Duration(seconds: 1));
        count--;
        if (_streamController.isClosed) break;
        _streamController.add(count);
      }
    }
  }

  Widget? counterSuffixIcon() {
    if (widget.data.suffix != null) return widget.data.suffix;
    // 密码输入框后的眼睛
    if (widget.data.validatorType == HbValidatorType.confirmPass ||
        widget.data.validatorType == HbValidatorType.password) {
      return Icon(
        _hidePassword ? Icons.visibility_off : Icons.visibility,
        size: 18.w,
      ).pr(10.w).onGestureTap(() {
        _hidePassword = !_hidePassword;
        if (mounted) setState(() {});
      });
    } else if (widget.data.validatorType == HbValidatorType.code) {
      // 发送按钮
      return Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: StreamBuilder<Object>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data != 0) {
              return HbButton(height: 28.w, text: '${snapshot.data}s');
            } else {
              // 发送验证码
              return HbButton(
                height: 28.w,
                text: HbCommonLocalizations.current.send,
                onTap: _sendCode,
              );
            }
          },
        ),
      );
    } else {
      // 清除按钮, 存在内容时才显示
      return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, __) {
          return Visibility(
            visible: value.text.isNotEmpty,
            child: Icon(
              Icons.cancel,
              size: 16.w,
              color: Theme.of(context).colorScheme.onSurface,
            ).pr(10.w).onGestureTap(() {
              _controller.clear();
            }),
          );
        },
      );
    }
  }

  HbValidatorFnType validator() {
    // 自定义了validator，就使用自定义的validator
    if (widget.data.validator != null) {
      return widget.data.validator;
    }
    switch (widget.data.validatorType) {
      case HbValidatorType.email:
        return FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]);
      case HbValidatorType.password:
        return FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.password(),
        ]);
      case HbValidatorType.confirmPass:
        return (String? v) {
          v = v!.trim();
          var passwordVerifyFn = FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.password(),
          ]);
          var err = passwordVerifyFn(v);
          if (err != null) return err;
          if (v != widget.data.preController?.text) {
            return HbCommonLocalizations.current.confirmPasswordError;
          }
          return null;
        };
      case HbValidatorType.require:
      case HbValidatorType.code:
        return FormBuilderValidators.required();
    }
  }

  void _setName(String value) {
    if (widget.data.name != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //  如果是密码输入框，将密码加密
        if (widget.data.validatorType == HbValidatorType.password) {
          widget.formValue?[widget.data.name!] = HbCrypto.sha256String(value);
        } else {
          widget.formValue?[widget.data.name!] = value;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.data.show,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.data.label != null || widget.data.labelWeight != null
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.data.labelWeight ??
                      Text(
                        widget.data.label!,
                        style:
                            Theme.of(context).inputDecorationTheme.labelStyle ??
                            HbStyle.text14,
                      ),
                  widget.data.rightLabel ?? const SizedBox(),
                ],
              ).pb(8.w)
              : const SizedBox(),
          TextFormField(
            initialValue: widget.data.initialValue,
            focusNode: _focusNode,
            inputFormatters: widget.data.inputFormatters,
            key: widget.data.inputKey,
            onTap: widget.data.onTap,
            readOnly: widget.data.readOnly ?? false,
            controller: widget.data.initialValue == null ? _controller : null,
            autofocus: widget.data.autofocus,
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: _hidePassword,
            maxLength: widget.data.maxLength,
            maxLines: widget.data.maxLines ?? 1,
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(
                maxHeight: 24.w,
                minHeight: 0,
              ),
              prefixIcon: widget.data.prefix?.px(8.w),
              isCollapsed: true,
              enabled: widget.data.enabled,
              hintText: widget.data.hintText,
              hintStyle:
                  Theme.of(context).inputDecorationTheme.hintStyle ??
                  HbStyle.text12Grey,
              suffixIconConstraints: BoxConstraints(
                maxHeight: 24.w,
                minHeight: 0,
              ),
              suffixIconColor: HbColor.textGrey,
              suffixIcon: counterSuffixIcon(),
            ),
            validator: validator(),
            textInputAction: widget.data.textInputAction,
            keyboardType: widget.data.keyboardType,
            onChanged: (String value) {
              widget.data.onChanged?.call(value);
            },
            onFieldSubmitted: widget.data.onFieldSubmitted,
          ),
        ],
      ),
    );
  }
}
