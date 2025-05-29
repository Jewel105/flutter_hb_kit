import 'package:flutter/material.dart';

import 'hb_form_model.dart';

class FormSchema extends StatelessWidget {
  final List<Widget> children;
  final HbFormController? formController;

  const FormSchema({super.key, required this.children, this.formController});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formController?.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            children.map((w) {
              if (w is HbFormWidget) {
                return w..setFormValue(formController?.value);
              }
              return w;
            }).toList(),
      ),
    );
  }
}
