import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/audio_message_widget.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/text_message_widget.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/video_message_widget.dart';
import 'package:ngandika_app/utils/enums/message_type.dart';

import 'image_message_widget.dart';

class MessageContentType extends StatelessWidget {
  final MessageModel messageData;
  final bool isSender;

  const MessageContentType({Key? key, required this.isSender, required this.messageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(messageData.messageType) {
      case MessageType.text:
        return TextMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.image:
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.video:
        return VideoMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.gif:
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.audio:
        return AudioMessageWidget(messageData: messageData, isSender: isSender);

      default:
        return TextMessageWidget(messageData: messageData, isSender: isSender);
    }
      
  }
}
