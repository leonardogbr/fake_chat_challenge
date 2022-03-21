import 'package:fake_chat/enums/message_direction.enum.dart';

extension MessageDirectionExtension on MessageDirection {
  MessageDirection getValue(String value) {
    MessageDirection result;

    switch (value.toLowerCase()) {
      case 'received':
        result = MessageDirection.received;
        break;
      case 'sent':
        result = MessageDirection.sent;
        break;
    }

    return result;
  }
}
