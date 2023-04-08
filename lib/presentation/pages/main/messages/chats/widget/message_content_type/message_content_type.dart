import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/text_message_widget.dart';
import 'package:ngandika_app/utils/enums/message_type.dart';

class MessageContentType extends StatelessWidget {
  final MessageModel messageData;

  const MessageContentType({Key? key, required this.messageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(messageData.messageType) {
      case MessageType.text:
        return TextMessageWidget(messageData: messageData);
      case MessageType.image:

      case MessageType.audio:
      case MessageType.video:
      case MessageType.gif:
      default:
        return TextMessageWidget(messageData: messageData);
    }
      
  }
}
