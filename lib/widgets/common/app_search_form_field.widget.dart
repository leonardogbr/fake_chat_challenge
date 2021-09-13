import 'package:fake_chat/theme/app.theme.dart';
import 'package:flutter/material.dart';

class AppSearchFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChange;

  AppSearchFormField({
    @required this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        style: AppTheme.inputTextStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'Buscar...',
          hintStyle: AppTheme.inputHintStyle,
        ),
        autofocus: true,
        onChanged: onChange,
      );
}
