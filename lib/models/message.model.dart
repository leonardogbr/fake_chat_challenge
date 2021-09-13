import 'package:fake_chat/enums/message_status.enum.dart';
import 'package:fake_chat/extensions/message_status.extension.dart';

class Message {
  String id;
  String content;
  DateTime createdDate;
  String from;
  String to;
  MessageStatus status;

  Message({this.id, this.content, this.createdDate, this.from, this.to, this.status});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'],
        content: json['content'],
        createdDate: DateTime.parse(json['createdDate']),
        from: json['from'],
        to: json['to'],
        status: MessageStatus.unknown.getValue(json['status']),
      );
}
