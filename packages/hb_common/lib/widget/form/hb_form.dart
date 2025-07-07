import 'package:flutter/material.dart';

import 'hb_form_model.dart';

class HbForm extends StatelessWidget {
  final List<Widget> children;
  final HbFormController? formController;

  const HbForm({super.key, required this.children, this.formController});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formController?.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map(_initialFormValue).toList(),
      ),
    );
  }

  Widget _initialFormValue(Widget w) {
    if (w is HbFormWidget) {
      w.setFormValue(formController?.value);
    } else if (w is SingleChildRenderObjectWidget && w.child != null) {
      _initialFormValue(w.child!);
    } else if (w is MultiChildRenderObjectWidget) {
      w.children.forEach(_initialFormValue);
    }
    return w;
  }
}
