import 'package:fake_chat/theme/app.theme.dart';
import 'package:flutter/material.dart';

class ChatListTileDivider extends StatelessWidget {
  const ChatListTileDivider();

  @override
  Widget build(BuildContext context) => const Divider(
        height: 1,
        thickness: 1,
        color: AppTheme.cd2dfe6,
      );
}
