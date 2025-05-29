import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/hb_color.dart';
import '../../extensions/index.dart';
import '../../localization/hb_common_localizations.dart';
import '../hb_icon.dart';
import 'hb_form_model.dart';
import 'hb_input.dart';

// 底部弹窗选择框
// ignore: must_be_immutable
class HbSelect extends HbFormWidget {
  final HbFormData data;
  Map<String, dynamic>? formValue;

  HbSelect.fromData(this.data, {super.key});

  HbSelect({
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
  State<HbSelect> createState() => _HbSelectState();

  @override
  void setFormValue(Map<String, dynamic>? value) {
    formValue = value;
  }

  /// 弹出底部选择弹窗
  static showBottomSelector(
    BuildContext context, {
    String? title, // title
    required List<HbSelectItemModel> items, // 下拉选项
    bool showIcon = true, // 是否显示图标
    bool showDescription = true, // 是否显示描述
    required HbRadioController controller, // 初始选中项下标与selectItem
    // 选项发生变化
    ValueChanged<int>? onSelected, //选项发生变化
  }) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: 620.w),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _SelectDialog(
          title: title,
          items: items,
          showIcon: showIcon,
          showDescription: showDescription,
          controller: controller,
          onSelected: onSelected,
        );
      },
    );
  }

  /// 设置默认选中
  static void setDefaultSelect({
    List<HbSelectItemModel>? list,
    required HbRadioController controller,
    String? value,
  }) {
    if (list != null && list.isNotEmpty) {
      if (value != null) {
        for (var e in list) {
          if (e.code == value) {
            controller.selectItem.value = e;
            controller.curIndex.value = list.indexOf(e);
          }
        }
      } else if (controller.curIndex.value != -1 &&
          controller.curIndex.value < list.length) {
        controller.selectItem.value = list[controller.curIndex.value];
      } else {
        controller.curIndex.value = 0;
        controller.selectItem.value = list.firstOrNull;
      }
    } else {
      controller.selectItem.value = null;
      controller.curIndex.value = -1;
    }
  }
}

class _HbSelectState extends State<HbSelect> {
  late HbRadioController _radioController;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _radioController = widget.data.radioController ?? HbRadioController();
    // 初始化选项
    HbSelect.setDefaultSelect(
      controller: _radioController,
      list: widget.data.selectItems,
      value: _radioController.selectItem.value?.code,
    );
    _textController = widget.data.controller ?? TextEditingController();
    _setName(_radioController.selectItem.value);
  }

  void _setName(HbSelectItemModel? curSelectItem) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textController.text = curSelectItem?.code ?? '';
      if (widget.data.name != null) {
        widget.formValue?[widget.data.name!] =
            _radioController.selectItem.value?.code ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.data.show,
      child: ListenableBuilder(
        listenable: Listenable.merge([
          _radioController.curIndex,
          _radioController.selectItem,
        ]),
        builder: (context, _) {
          HbSelectItemModel? curSelectItem = _radioController.selectItem.value;
          _setName(curSelectItem);
          return HbInput.fromData(
            HbFormData(
              label: widget.data.label,
              hintText:
                  widget.data.hintText ??
                  HbCommonLocalizations.current.pleaseSelect,
              controller: _textController,
              prefix:
                  (widget.data.showIcon)
                      ? HbIcon(
                        icon: curSelectItem?.icon,
                        key: ValueKey(curSelectItem?.icon),
                        width: 24.w,
                        defaultIcon: const SizedBox(),
                      )
                      : null,
              readOnly: widget.data.readOnly ?? true,
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible:
                        widget.data.readOnly == null
                            ? false
                            : !widget.data.readOnly!,
                    child: IconButton(
                      iconSize: 16.w,
                      onPressed: () {
                        _textController.clear();
                        _radioController.clear();
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
              onTap: () {
                if (!widget.data.enabled) return;
                // 点击打开下拉弹窗
                HbSelect.showBottomSelector(
                  context,
                  showIcon: widget.data.showIcon,
                  showDescription: widget.data.showDescription,
                  title: widget.data.label,
                  items: widget.data.selectItems,
                  controller: _radioController,
                  onSelected: (index) {
                    // 更改文本内容
                    _textController.text =
                        _radioController.selectItem.value?.code ?? '';
                    if (widget.data.name != null) {
                      widget.formValue?[widget.data.name!] =
                          _radioController.selectItem.value?.code ?? '';
                    }
                    widget.data.onSelected?.call(index);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _SelectDialog extends StatelessWidget {
  final String? title; // title
  final List<HbSelectItemModel> items; // 下拉选项
  final bool showIcon; // 是否显示图标
  final bool showDescription; // 是否显示描述
  final HbRadioController controller; // 初始选中项下标与selectItem
  // 选项发生变化
  final ValueChanged<int>? onSelected; //选项发生变化
  const _SelectDialog({
    this.title,
    required this.items,
    required this.controller,
    this.onSelected,
    required this.showIcon,
    required this.showDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.w),
            topRight: Radius.circular(16.w),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // title
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 8.w),
              padding: EdgeInsets.symmetric(vertical: 16.w),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.w, color: HbColor.bgGreyLight),
                ),
              ),
              child: Text(
                title ?? HbCommonLocalizations.current.pleaseSelect,
                style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w600),
              ),
            ),
            // items
            SafeArea(
              minimum: EdgeInsets.only(bottom: 16.w),
              child: Column(
                children:
                    items.map((e) {
                      int index = items.indexOf(e);
                      return InkWell(
                        onTap: () {
                          controller.curIndex.value = index;
                          controller.selectItem.value = items[index];
                          Navigator.of(context).pop();
                          onSelected?.call(index);
                        },
                        child: Container(
                          color:
                              controller.curIndex.value == index
                                  ? HbColor.bgGreyLight
                                  : null,
                          padding: EdgeInsets.all(16.w),
                          child: ListenableBuilder(
                            listenable: Listenable.merge([
                              controller.curIndex,
                              controller.selectItem,
                            ]),
                            builder: (context, _) {
                              return Row(
                                children: [
                                  showIcon
                                      ? HbIcon(
                                        icon: e.icon,
                                        width: 32.w,
                                        defaultIcon: const SizedBox(),
                                      )
                                      : const SizedBox(),
                                  SizedBox(width: showIcon ? 12.w : 0.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.code,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Visibility(
                                          visible: showDescription,
                                          child: Text(
                                            e.description,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              height: 20 / 12,
                                              color: HbColor.textGrey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.curIndex.value == index,
                                    child: Icon(
                                      Icons.check_circle_rounded,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 20.w,
                                    ).pl(16.w),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
