import 'package:fake_chat/theme/app.theme.dart';
import 'package:fake_chat/widgets/common/app_search_form_field.widget.dart';
import 'package:flutter/material.dart';

class AppBarSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSearch;
  final Function() clear;
  final Function(String) search;

  AppBarSearchWidget({
    @required this.controller,
    @required this.onSearch,
    @required this.clear,
    @required this.search,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 10,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppTheme.c505f79,
          ),
          onPressed: onSearch,
        ),
        Expanded(
          child: AppSearchFormField(
            controller: controller,
            onChange: search,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 10,
          icon: Icon(
            Icons.clear,
            size: 22,
            color: AppTheme.c505f79,
          ),
          onPressed: clear,
        ),
      ],
    );
  }
}
