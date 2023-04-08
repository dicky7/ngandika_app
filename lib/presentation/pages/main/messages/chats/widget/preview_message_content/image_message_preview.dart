import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/preview_message_content/app_bar_message_preview.dart';

class ImageMessagePreview extends StatelessWidget {
  static const routeName = "image-message-preview";
  final MessageModel messageData;

  const ImageMessagePreview({Key? key, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMessagePreview(messageData: messageData),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: messageData.text,
          width: double.infinity,
          fit: BoxFit.contain,
          placeholder: (context, url) => const CircularProgressIndicator()
        ),
      )
    );
  }
}
