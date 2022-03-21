import 'package:blip_sdk/blip_sdk.dart';
import 'package:fake_chat/enums/message_direction.enum.dart';
import 'package:fake_chat/extensions/message_direction.extension.dart';

class TicketMessage extends Message {
  MessageDirection direction;
  DateTime date;

  TicketMessage({
    final String id,
    final Node from,
    final Node to,
    final Node pp,
    final Map<String, dynamic> metadata,
    final String type,
    final dynamic content,
    this.direction,
    this.date,
  }) : super(
          id: id,
          from: from,
          to: to,
          pp: pp,
          metadata: metadata,
          type: type,
          content: content,
        );

  factory TicketMessage.fromJson(Map<String, dynamic> json) => TicketMessage(
        id: json['id'],
        from: json['from'] != null ? Node.parse(json['from']) : null,
        to: json['to'] != null ? Node.parse(json['to']) : null,
        pp: json['pp'] != null ? Node.parse(json['pp']) : null,
        metadata: json['metadata'],
        type: json['type'],
        content: json['content'],
        direction: MessageDirection.unknown.getValue(json['direction']),
        date: DateTime.fromMillisecondsSinceEpoch(DateTime.parse(json['date']).toUtc().millisecondsSinceEpoch,
            isUtc: true),
      );
}
