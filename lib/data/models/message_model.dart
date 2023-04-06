import 'package:equatable/equatable.dart';
import 'package:ngandika_app/utils/enums/message_type.dart';

class MessageModel extends Equatable {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageType messageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  const MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.messageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'type': messageType.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      text: map['text'],
      messageType: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'],
      isSeen: map['isSeen'],
    );
  }

  @override
  List<Object> get props => [
        senderId,
        receiverId,
        text,
        messageType,
        timeSent,
        messageId,
        isSeen,
      ];
}
