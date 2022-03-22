import 'package:fake_chat/controllers/chat.controller.dart';
import 'package:fake_chat/widgets/chat/chat_list_app_bar.widget.dart';
import 'package:fake_chat/widgets/chat/chat_list_tile.widget.dart';
import 'package:fake_chat/widgets/chat/chat_list_tile_divider.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListPage extends StatelessWidget {
  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatListAppBar(),
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: controller.refresh,
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChatListTile(
                          chat: controller.filteredList[index],
                        ),
                        const ChatListTileDivider(),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
