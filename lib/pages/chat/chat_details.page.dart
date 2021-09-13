import 'package:fake_chat/controllers/chat.controller.dart';
import 'package:fake_chat/widgets/common/app_text_form_field.widget.dart';
import 'package:fake_chat/widgets/chat/chat_message.widget.dart';
import 'package:fake_chat/widgets/common/send_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:fake_chat/models/chat.model.dart';
import 'package:fake_chat/widgets/chat/chat_details_app_bar.widget.dart';
import 'package:get/get.dart';

class ChatDetailPage extends StatelessWidget {
  final controller = Get.put(ChatController());
  final Chat chat;

  ChatDetailPage({@required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailsAppBar(
        image: chat.image,
        name: chat.name,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: controller.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = controller.chatMessages[index];

                    return ChatMessage(
                      message: message,
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
