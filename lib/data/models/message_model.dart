import 'package:equatable/equatable.dart';
import 'package:ngandika_app/utils/enums/message_type.dart';

class MessageModel extends Equatable {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String text;
  final MessageType messageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  //replay message
  final String repliedMessage;
  final String repliedTo;
  final MessageType repliedMessageType;

  const MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.messageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.senderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'messageType': messageType.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
      'senderName': senderName,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      messageType: (map['messageType'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
      repliedMessage: map['repliedMessage'] as String,
      repliedTo: map['repliedTo'] as String,
      repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
      senderName: map['senderName'],
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
        repliedMessage,
        repliedTo,
        repliedMessageType,
      ];


}
