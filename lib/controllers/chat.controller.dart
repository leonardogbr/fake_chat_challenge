import 'dart:async';
import 'dart:convert';

import 'package:fake_chat/models/chat.model.dart';
import 'package:fake_chat/models/message.model.dart';
import 'package:fake_chat/pages/chat/chat_details.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final list = RxList<Chat>();
  final filteredList = RxList<Chat>();

  final chatMessages = RxList<Message>();
  final isSearching = RxBool(false);

  final searchFieldController = TextEditingController();
  final addMessageFieldController = TextEditingController();

  ChatController() {
    _initController();
  }

  Future<void> _initController() async {
    // Simulate api call
    String data = await rootBundle.loadString("assets/static/mock_data.json");
    final jsonResult = jsonDecode(data);

    final _tempList = List<Chat>();

    for (final json in jsonResult) {
      _tempList.add(Chat.fromJson(json));
    }

    list.assignAll(_tempList);
    _orderByLastMessage();

    filteredList.assignAll(list);
  }

  void _orderByLastMessage({bool applySearch = false}) {
    // Order by lastMessage desc
    list.sort((a, b) => b.lastMessage.createdDate.compareTo(a.lastMessage.createdDate));

    // If a new message was created through a filter in the list screen, apply the filter again
    if (applySearch)
      search(searchFieldController.text);
    else
      filteredList.assignAll(list);
  }

  Future<void> refresh() async {
    /// Here would be the moment when the data would be fetched again in the api, in this case,
    /// a timer was simulated and just ordered again

    await Future.delayed(const Duration(seconds: 3));

    _orderByLastMessage(applySearch: (searchFieldController.text?.isNotEmpty ?? false));
  }

  void goToDetailsPage(Chat chat) {
    Get.to(
      () => ChatDetailPage(
        chat: chat,
      ),
    );

    // Rx variable to listen on DetailsPage (for any changes)
    chatMessages.assignAll(chat.messages);
  }

  void sendMessage(Chat chat) {
    final content = addMessageFieldController.text;

    if (content?.trim()?.isEmpty ?? true) return;

    // Simulates api call for message insertion (adds message to memory)
    final messages = chat.messages;

    final message = Message(
      content: content,
      createdDate: DateTime.now(),
      from: 'me',
      to: chat.identity,
    );

    // Inserts message at the beginning of list. ListView.builder is inverted (from bottom to top)
    messages.insert(
      0,
      message,
    );

    // Update chat lastMessage
    chat.lastMessage = message;

    chatMessages.assignAll(messages);

    addMessageFieldController.clear();

    _orderByLastMessage(applySearch: (searchFieldController.text?.isNotEmpty ?? false));

    // Bot response simulation
    Timer(
      Duration(milliseconds: 1500),
      () {
        final message = Message(
          content:
              'Olá, Sou seu assistente virtual. Ainda estou aprendendo a entender tudo o que você precisa. (Simulação Bot)',
          createdDate: DateTime.now(),
          from: chat.identity,
          to: 'me',
        );

        messages.insert(
          0,
          message,
        );

        chat.lastMessage = message;

        chatMessages.assignAll(messages);

        _orderByLastMessage(applySearch: (searchFieldController.text?.isNotEmpty ?? false));
      },
    );
  }

  void search(String searchString) {
    filteredList.assignAll(list.where((x) => x.name.toLowerCase().contains(searchString.toLowerCase())));
  }

  void clear() {
    searchFieldController.clear();
    filteredList.assignAll(list);
  }
}
