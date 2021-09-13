import 'dart:convert';
import 'dart:typed_data';
import 'package:fake_chat/models/message.model.dart';

class Chat {
  String identity;
  String name;
  Message lastMessage;
  List<Message> messages;
  Uint8List image;

  Chat({this.identity, this.name, this.lastMessage, this.messages, this.image});

  factory Chat.fromJson(Map<String, dynamic> json) {
    final _messages = List<Message>();

    for (final jsonMessage in json['messages']) {
      _messages.add(Message.fromJson(jsonMessage));
    }

    _messages.sort((a, b) => b.createdDate.compareTo(a.createdDate));

    return Chat(
      identity: json['identity'],
      name: json['name'],
      lastMessage: Message.fromJson(json['last_message']),
      messages: _messages,
      image: base64Decode(
        json['image'].replaceAllMapped(
          RegExp(r'^data:image\/[a-z]+;base64,', caseSensitive: false),
          (match) => '',
        ),
      ),
    );
  }
}
