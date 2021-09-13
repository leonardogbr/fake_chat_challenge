import 'package:fake_chat/theme/app.theme.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final Function onPressed;

  SendButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) => FlatButton(
        padding: const EdgeInsets.all(12),
        minWidth: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppTheme.c52c7d7,
        child: Image.asset(
          'assets/images/SendButton.png',
          height: 25,
        ),
        onPressed: onPressed,
      );
}
