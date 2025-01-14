import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_task/core/values/colors.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';

import 'form_label.dart';

class AppTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final String? headerText;
  final String? initialValue;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String? descriptionText;
  final int lines;
  final bool readOnly;
  final bool enabled;
  final bool? autoFocus;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? textInputFormatters;
  final void Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final TextEditingController? controller;

  const AppTextFieldWidget({
    super.key,
    this.focusNode,
    this.headerText,
    this.hintText,
    this.obscureText = false,
    this.prefixWidget,
    this.suffixWidget,
    this.readOnly = false,
    this.enabled = true,
    this.lines = 1,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.textInputFormatters,
    this.onChanged,
    this.onSubmit,
    this.controller,
    this.validator,
    this.autoFocus,
    this.textInputType,
    this.descriptionText,
    this.onSaved,
    this.initialValue,
  }) : assert(initialValue == null || controller == null);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: headerText,
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabelWidget(headerText: headerText),
          TextFormField(
            minLines: lines,
            maxLines: lines,
            focusNode: focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: headerText == null ? UniqueKey() : ValueKey(headerText!),
            initialValue: initialValue,
            autofocus: autoFocus ?? false,
            controller: controller,
            textInputAction: textInputAction,
            inputFormatters: textInputFormatters,
            enabled: enabled,
            readOnly: readOnly || onTap != null,
            obscureText: obscureText,
            onChanged: onChanged,
            validator: validator,
            onSaved: onSaved,
            onTap: onTap,
            style: context.theme.textTheme.labelLarge,
            keyboardType: textInputType,
            cursorColor: AppColors.black,
            cursorWidth: 1,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixWidget,
              suffixIcon: suffixWidget,
            ),
          ),
        ],
      ),
    );
  }
}
