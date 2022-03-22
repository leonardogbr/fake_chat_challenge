import 'dart:async';

import 'package:fake_chat/controllers/chat.controller.dart';
import 'package:fake_chat/enums/chat_state_types.enum.dart';
import 'package:fake_chat/enums/message_direction.enum.dart';
import 'package:fake_chat/models/ticket_message.model.dart';
import 'package:fake_chat/widgets/common/app_text_form_field.widget.dart';
import 'package:fake_chat/widgets/chat/chat_message.widget.dart';
import 'package:fake_chat/widgets/common/send_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:fake_chat/models/chat.model.dart';
import 'package:fake_chat/widgets/chat/chat_messages_app_bar.widget.dart';
import 'package:get/get.dart';

class ChatMessagesPage extends StatelessWidget {
  final controller = Get.find<ChatController>();
  final Chat chat;

  ChatMessagesPage({@required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatMessagesAppBar(
        name: chat.customerIdentity.toString(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: controller.chatMessages.length + (controller.isComposing.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    final message = controller.isComposing.value && index == 0
                        ? TicketMessage(
                            direction: MessageDirection.received,
                            content: '',
                          )
                        : controller.chatMessages[index - (controller.isComposing.value ? 1 : 0)];

                    return ChatMessage(
                      message: message,
                      isComposing: index == 0 && controller.isComposing.value,
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Scrollbar(
                      radius: const Radius.circular(5),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 120.0,
                        ),
                        child: AppTextFormField(
                          controller: controller.addMessageFieldController,
                          hint: 'Digite sua mensagem',
                          textInputAction: TextInputAction.newline,
                          maxLines: null,
                          onChanged: (val) {
                            if (controller.currentChatState != ChatStateTypes.composing)
                              controller.sendChatState(chat.id, ChatStateTypes.composing);

                            if (controller.debounce?.isActive ?? false) controller.debounce.cancel();
                            controller.debounce = Timer(const Duration(seconds: 2), () {
                              controller.sendChatState(chat.id, ChatStateTypes.paused);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SendButton(
                    onPressed: () {
                      controller.sendMessage(chat);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
