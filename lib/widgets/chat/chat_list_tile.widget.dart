import 'package:fake_chat/controllers/chat.controller.dart';
import 'package:fake_chat/models/chat.model.dart';
import 'package:fake_chat/theme/app.theme.dart';
import 'package:fake_chat/widgets/chat/chat_last_message_time.widget.dart';
import 'package:fake_chat/widgets/common/custom_avatar.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListTile extends StatelessWidget {
  final controller = Get.put(ChatController());
  final Chat chat;

  ChatListTile({@required this.chat});

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: CustomAvatar(
          image: chat.image,
        ),
        title: Text(
          chat.name,
          style: AppTheme.chatListTitleStyle,
        ),
        trailing: ChatLastMessageTime(message: chat.lastMessage),
        onTap: () {
          /// CAUTION
          /// The Ideal in a real app, which fetches the data from api, would be in the listing, search only the
          /// data used in the listing (id, image, name and date), and when clicking to go to details
          /// fetch messages based on conversation.
          /// As the data is already mocked in the complete structure, the chat messages will be passed to the details page.

          controller.goToDetailsPage(chat);
        },
      );
}
