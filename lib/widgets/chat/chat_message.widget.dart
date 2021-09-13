import 'package:fake_chat/models/message.model.dart';
import 'package:fake_chat/theme/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  final Message message;

  ChatMessage({@required this.message});

  @override
  Widget build(BuildContext context) {
    final mainMessage = message.from == 'me';

    final alignment = mainMessage ? Alignment.centerRight : Alignment.centerLeft;
    final dateFormat = DateFormat('h:mm a');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          Align(
            alignment: alignment,
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: mainMessage ? AppTheme.c125ad5 : AppTheme.ce7edf4,
                borderRadius: BorderRadius.only(
                  topLeft: mainMessage ? const Radius.circular(15) : const Radius.circular(2),
                  topRight: mainMessage ? const Radius.circular(2) : const Radius.circular(15),
                  bottomLeft: const Radius.circular(15),
                  bottomRight: const Radius.circular(15),
                ),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: mainMessage ? Colors.white : AppTheme.c505f79,
                ),
              ),
            ),
          ),
          Align(
            alignment: alignment,
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Text(
                dateFormat.format(message.createdDate),
                style: AppTheme.chatMessageDateStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
