import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_reply_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message/message_reply_card.dart';

class MessageReplyPreview extends StatelessWidget {
  final MessageReplyModel messageReply;
  const MessageReplyPreview({Key? key, required this.messageReply}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      child: MessageReplyCard(
          showCloseButton: true,
          repliedMessageType: messageReply.messageType,
          text: messageReply.message,
          isMe: messageReply.isMe,
          repliedTo: messageReply.repliedTo
      ),
    );
  }
}
