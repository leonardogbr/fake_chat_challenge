import 'package:fake_chat/enums/message_status.enum.dart';

extension MessageStatusExtension on MessageStatus {
  String getDescription() {
    var description;

    switch (this) {
      case MessageStatus.received:
        description = 'Recebido';
        break;
      case MessageStatus.delivered:
        description = 'Entregue';
        break;
      case MessageStatus.notDelivered:
        description = 'Não Entregue';
        break;
      case MessageStatus.seen:
        description = 'Visto';
        break;
      default:
        description = 'Desconhecido';
    }

    return description;
  }

  MessageStatus getValue(String stringValue) {
    MessageStatus value;

    switch (stringValue.toLowerCase()) {
      case 'received':
        value = MessageStatus.received;
        break;
      case 'delivered':
        value = MessageStatus.delivered;
        break;
      case 'notDelivered':
        value = MessageStatus.notDelivered;
        break;
      case 'seen':
        value = MessageStatus.seen;
        break;
      default:
        value = MessageStatus.unknown;
    }

    return value;
  }
}
