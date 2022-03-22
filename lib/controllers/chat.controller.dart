import 'dart:async';
import 'package:blip_sdk/blip_sdk.dart';
import 'package:fake_chat/enums/chat_state_types.enum.dart';
import 'package:fake_chat/enums/message_direction.enum.dart';
import 'package:fake_chat/models/chat.model.dart';
import 'package:fake_chat/models/ticket_message.model.dart';
import 'package:fake_chat/pages/chat/chat_messages.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart' as getx;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class ChatController extends GetxController {
  final Client sdkClient;

  final list = <Chat>[].obs;
  final filteredList = <Chat>[].obs;

  final chatMessages = <TicketMessage>[].obs;
  final isSearching = false.obs;
  final isComposing = false.obs;
  final isLoading = false.obs;
  ChatStateTypes currentChatState = ChatStateTypes.paused;

  final searchFieldController = TextEditingController();
  final addMessageFieldController = TextEditingController();

  final sessionFinishedHandler = StreamController<Session>();
  final onMessageListener = StreamController<Message>();
  void Function() onRemoveMessageListener;
  String selectedTicketId;
  Timer debounce;

  ChatController()
      : sdkClient = ClientBuilder(transport: WebSocketTransport())
            .withIdentifier('leonardo.gabriel%40take.net')
            .withEcho(false)
            .withNotifyConsumed(false)
            .withDomain('blip.ai')
            .withHostName('contrato-test-msqz9.hmg-ws.blip.ai')
            .withInstance('!desk')
            .withToken(
                'eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlY2RmZmViNjJlYjA0ZWYwMzE1OWI0OGZiNTNiZGZjIiwidHlwIjoiSldUIn0.eyJuYmYiOjE2NDc4NzAxMzEsImV4cCI6MTY0Nzk1NjUzMSwiaXNzIjoiaHR0cHM6Ly9obWctYWNjb3VudC5ibGlwLmFpIiwiYXVkIjoiaHR0cHM6Ly9obWctYWNjb3VudC5ibGlwLmFpL3Jlc291cmNlcyIsImNsaWVudF9pZCI6ImJsaXAtZGVzayIsInN1YiI6ImVlMTU5ODQyLTAxYjQtNDFkZC04OWJiLTExMjhlYmQ4MWVjNSIsImF1dGhfdGltZSI6MTY0Nzg3MDEzMSwiaWRwIjoiZ29vZ2xlIiwiUHJvdmlkZXJEaXNwbGF5TmFtZSI6Imdvb2dsZSIsIkZ1bGxOYW1lIjoiTGVvbmFyZG8gR2FicmllbCIsIlVzZXJOYW1lIjoibGVvbmFyZG8uZ2FicmllbEB0YWtlLm5ldCIsImN1bHR1cmUiOiJwdC1CUiIsIkNyZWF0ZWRCeU5ld0FjY291bnRSZWdpc3RlciI6IkZhbHNlIiwiRW1haWwiOiJsZW9uYXJkby5nYWJyaWVsQHRha2UubmV0IiwiRW1haWxDb25maXJtZWQiOiJUcnVlIiwic2NvcGUiOlsib3BlbmlkIiwicHJvZmlsZSIsImVtYWlsIl0sImFtciI6WyJleHRlcm5hbCJdfQ.XlseAnOG7wGrdocbp3Up2BIyLQwIQCXoyAKx7oIrIvdMQ3DUYDhCk32GYMER8cUc1ZYpPDsYsxAo7aLT6rhz_zZT13A2G5iiEvw1DN8AMrvLO0Jzol8n8rRFYtJmPeq8XL5tNJHTdJfQpQbNzi4ITc5otXOXfq9I3ZvseiiAIqs8h0Ug-BaSMzCMliYnKtqSwyyrbw6SBGRzR5ufTj6eCFpyJm9xfIdBgRzpAxrtQ2jOss1pJ1LnV7EK-jsL2pktgKg1yWstf53NSC8Be_RqREuPjhXgzOGNPaH1cw_SB_ryOxHe_mGzajPMDnOC4gE6FFZCKXSNzUd5GPdOdaneP-e3dw4muKvjFruUcV11otEDHtIWyOso2www0D-_BIB22ME4PuzgRMuPqixbT0j31ykM9U7TefmuDD8JuVJMrluZUzvHwd1f9wOAUasWOH7-9X16ZEXd8TsSL1bHkH9k_gsV1ASp0QyjxDagMw8PUb6VoxuhGZzfpIYN1bSqv40GMNPt6qMK1AWSMmTOcvrFiKpAf1XfkJKmSsUbakY0VsvzM4CFSzqS5r4Of_wjmk1QwbgkeiTesnN19_RVz48vMILyrrWLFoPX1kjhY8EuhTKOvhtpUFuuFzFlNv4qNeh7tzJYkOx3W6aDC4iljpq1DD-zoqU-4oL1CMODXchx8iI',
                'account.blip.ai')
            .build() {
    _initController();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    sessionFinishedHandler.close();
    onMessageListener.close();
    sdkClient.close();

    super.onClose();
  }

  Future<void> _initController() async {
    isLoading.value = true;
    await connect();

    sdkClient.addSessionFinishedHandlers(sessionFinishedHandler);

    onRemoveMessageListener = sdkClient.addMessageListener(onMessageListener);

    _initListeners();

    await _getTickets();

    isLoading.value = false;
  }

  _initListeners() {
    onMessageListener.stream.listen((message) {
      print('Message Received on Dart SDK: $message');

      print(message.toJson());

      if (message.from.toString().indexOf(selectedTicketId) >= 0) {
        if (message.type == 'application/vnd.lime.chatstate+json') {
          isComposing.value = message.content['state'] == 'composing';
        } else {
          isComposing.value = false;

          if (message.type == 'text/plain') {
            chatMessages.insert(
              0,
              TicketMessage(
                content: message.content,
                direction: MessageDirection.received,
                from: message.from,
                id: message.id,
                metadata: message.metadata,
                pp: message.pp,
                to: message.to,
                type: message.type,
                date: message.metadata['date_created'] != null
                    ? DateTime.fromMillisecondsSinceEpoch(int.parse(message.metadata['date_created']), isUtc: true)
                    : DateTime.now(),
              ),
            );
          }
        }
      }
    });

    sessionFinishedHandler.stream.listen((session) {
      print('event received successfully');
    });
  }

  _getTickets() async {
    // Simulate api call
    // String data = await rootBundle.loadString("assets/static/mock_data.json");
    final result = await sdkClient.sendCommand(
      Command(
        method: CommandMethod.get,
        uri: '/tickets/active',
        to: Node.parse('postmaster@desk.msging.net'),
      ),
    );

    print(result.resource['items']);

    // final jsonResult = jsonDecode(data);

    final _tempList = <Chat>[];

    for (final json in result.resource['items']) {
      _tempList.add(Chat.fromJson(json));
    }

    list.assignAll(_tempList);
    _orderByOpenDate();

    filteredList.assignAll(list);
  }

  connect() async {
    final result = await sdkClient.connect();

    print('State: ${result.state.toString()}');
  }

  disconnect() async {
    final result = await sdkClient.close();

    print('State: ${result?.state?.toString() ?? ''}');
  }

  void _orderByOpenDate({bool applySearch = false}) {
    // Order by lastMessage desc
    list.sort((a, b) => b.openDate.compareTo(a.openDate));

    // If a new message was created through a filter in the list screen, apply the filter again
    if (applySearch)
      search(searchFieldController.text);
    else
      filteredList.assignAll(list);
  }

  Future<void> refresh() async {
    /// Here would be the moment when the data would be fetched again in the api, in this case,
    /// a timer was simulated and just ordered again

    // await Future.delayed(const Duration(seconds: 3));
    await _getTickets();

    // _orderByLastMessage(applySearch: (searchFieldController.text?.isNotEmpty ?? false));
  }

  void goToDetailsPage(Chat chat) async {
    selectedTicketId = chat.id;

    // Rx variable to listen on DetailsPage (for any changes)
    chatMessages.assignAll(await getChatMessages(chat.id));

    Get.to(
      () => ChatMessagesPage(
        chat: chat,
      ),
    );
  }

  void sendMessage(Chat chat) {
    final content = addMessageFieldController.text;

    if (content?.trim()?.isEmpty ?? true) return;

    // Simulates api call for message insertion (adds message to memory)
    // final messages = chat.messages;

    final message = Message(
      content: content,
      type: 'text/plain',
      to: Node.parse('${chat.id}@desk.msging.net/Lime'),
    );

    // Message(
    //   to: Node.parse('9c7cf250-6a56-42ee-94df-017f4583c958@desk.msging.net/sdk'),
    //   type: 'text/plain',
    //   content: "Hello! This is a message sent using our new Dart SDK!",
    // )

    sdkClient.sendMessage(message);

    // Inserts message at the beginning of list. ListView.builder is inverted (from bottom to top)
    chatMessages.insert(
      0,
      TicketMessage(
        id: message.id,
        direction: MessageDirection.sent,
        content: message.content,
        from: message.from,
        to: message.to,
        metadata: message.metadata,
        pp: message.pp,
        type: message.type,
        date: DateTime.now().toUtc(),
      ),
    );

    // Update chat lastMessage
    // chat.lastMessage = message;

    // chatMessages.assignAll(messages);

    addMessageFieldController.clear();

    // _orderByLastMessage(applySearch: (searchFieldController.text?.isNotEmpty ?? false));

    // // Bot response simulation
    // Timer(
    //   Duration(milliseconds: 1500),
    //   () {
    //     final message = Message(
    //       content:
    //           'Olá, Sou seu assistente virtual. Ainda estou aprendendo a entender tudo o que você precisa. (Simulação Bot)',
    //       createdDate: DateTime.now(),
    //       from: chat.identity,
    //       to: 'me',
    //     );

    //     messages.insert(
    //       0,
    //       message,
    //     );

    //     chat.lastMessage = message;

    //     chatMessages.assignAll(messages);

    //     _orderByLastMessage(applySearch: (searchFieldController.text?.isNotEmpty ?? false));
    //   },
    // );
  }

  void sendChatState(String id, ChatStateTypes type) {
    currentChatState = type;

    final message = Message(
      content: {'state': type.name.substring(0, 1).toUpperCase() + type.name.substring(1)},
      type: 'application/vnd.lime.chatstate+json',
      to: Node.parse('$id@desk.msging.net/Lime'),
    );

    sdkClient.sendMessage(message);
  }

  Future<List<TicketMessage>> getChatMessages(String id) async {
    print('getMessages: $id');
    final result = await sdkClient.sendCommand(
      Command(
        method: CommandMethod.get,
        uri: '/tickets/$id/messages?\$take=40&direction=desc&getFromOwnerIfTunnel=true',
        to: Node.parse('postmaster@desk.msging.net'),
      ),
    );

    print(result.resource['items']);

    final messages = <TicketMessage>[];

    for (final json in result.resource['items']) {
      messages.add(TicketMessage.fromJson(json));
    }

    return messages;
  }

  void search(String searchString) {
    filteredList
        .assignAll(list.where((x) => x.customerIdentity.toString().toLowerCase().contains(searchString.toLowerCase())));
  }

  void clear() {
    searchFieldController.clear();
    filteredList.assignAll(list);
  }
}
