import 'package:blip_sdk/blip_sdk.dart';
import 'package:fake_chat/models/ticket_message.model.dart';
import 'package:fake_chat/theme/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatLastMessageTime extends StatelessWidget {
  final TicketMessage message;

  ChatLastMessageTime({@required this.message});

  String _getTimeText() {
    final diff = DateTime.now().difference(message.date);
    if (diff.inMinutes < 1)
      return 'Agora';
    else if (diff.inDays < 1)
      return DateFormat('HH:mm').format(message.date);
    else
      return DateFormat('dd/MM/yyyy').format(message.date);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getTimeText(),
      style: AppTheme.chatListTrailingStyle,
    );
  }
}
