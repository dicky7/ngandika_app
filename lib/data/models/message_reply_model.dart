import 'package:ngandika_app/utils/enums/message_type.dart';

class MessageReplyModel{
  final String message;
  final bool isMe;
  final MessageType messageType;
  final String repliedTo;

  const MessageReplyModel({
    required this.message,
    required this.isMe,
    required this.messageType,
    required this.repliedTo,
  });
}