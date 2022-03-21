import 'package:fake_chat/enums/message_direction.enum.dart';
import 'package:fake_chat/models/ticket_message.model.dart';
import 'package:fake_chat/theme/app.theme.dart';
import 'package:fake_chat/widgets/common/jumping_dots.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  final TicketMessage message;
  final bool isComposing;

  ChatMessage({@required this.message, this.isComposing = false});

  @override
  Widget build(BuildContext context) {
    final mainMessage = message.direction == MessageDirection.sent;

    final alignment = mainMessage ? Alignment.centerRight : Alignment.centerLeft;
    final dateFormat = DateFormat('h:mm a');

    return (message.content is String || isComposing)
        ? Container(
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
                    child: isComposing
                        ? JumpingDots()
                        : Text(
                            message.content,
                            style: TextStyle(
                              color: mainMessage ? Colors.white : AppTheme.c505f79,
                            ),
                          ),
                  ),
                ),
                if (!isComposing)
                  Align(
                    alignment: alignment,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        dateFormat.format(DateTime.now()),
                        style: AppTheme.chatMessageDateStyle,
                      ),
                    ),
                  ),
              ],
            ),
          )
        : const SizedBox();
  }
}
