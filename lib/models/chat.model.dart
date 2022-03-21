import 'package:blip_sdk/blip_sdk.dart';

class Chat {
  String id;
  Node customerIdentity;
  Node ownerIdentity;
  Node agentIdentity;
  // String name;
  // Message lastMessage;
  // List<Message> messages;
  // Uint8List image;

  Chat({
    this.id,
    this.customerIdentity,
    this.ownerIdentity,
    this.agentIdentity,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    // final _messages = <Message>[];

    // for (final jsonMessage in json['messages']) {
    //   _messages.add(Message.fromJson(jsonMessage));
    // }

    // _messages.sort((a, b) => b.da.compareTo(a.createdDate));

    return Chat(
      id: json['id'],
      customerIdentity: Node.parse(json['customerIdentity']),
      ownerIdentity: Node.parse(json['ownerIdentity']),
      agentIdentity: Node.parse(json['agentIdentity']),
      // name: json['name'],
      // lastMessage: Message.fromJson(json['last_message']),
      // messages: _messages,
      // image: base64Decode(
      //   json['image'].replaceAllMapped(
      //     RegExp(r'^data:image\/[a-z]+;base64,', caseSensitive: false),
      //     (match) => '',
      //   ),
      // ),
    );
  }
}
