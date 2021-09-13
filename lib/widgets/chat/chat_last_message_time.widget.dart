import 'package:fake_chat/models/message.model.dart';
import 'package:fake_chat/theme/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatLastMessageTime extends StatelessWidget {
  final Message message;

  ChatLastMessageTime({@required this.message});

  String _getTimeText() {
    final diff = DateTime.now().difference(message.createdDate);
    if (diff.inMinutes < 1)
      return 'Agora';
    else if (diff.inDays < 1)
      return DateFormat('HH:mm').format(message.createdDate);
    else
      return DateFormat('dd/MM/yyyy').format(message.createdDate);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getTimeText(),
      style: AppTheme.chatListTrailingStyle,
    );
  }
}
