import 'package:fake_chat/theme/app.theme.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputAction textInputAction;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final void Function(String) onChanged;

  AppTextFormField({
    this.controller,
    this.hint,
    this.textInputAction,
    this.maxLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10),
          ),
          border: Border.all(
            width: 1,
            color: AppTheme.cd8e3e9,
          ),
        ),
        child: TextFormField(
          controller: controller,
          style: AppTheme.inputTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: AppTheme.inputHintStyle,
          ),
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          maxLines: maxLines,
          onChanged: onChanged,
        ),
      );
}
