import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/time_sent_message_widget.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/preview_message_content/image_message_preview.dart';

import '../../../../../../../data/models/message_model.dart';
import '../../../../../../../utils/styles/style.dart';
import '../../../../../../bloc/message/chat/chat_state.dart';

class ImageMessageWidget extends StatelessWidget {
  final MessageModel messageData;
  final bool isSender;

  const ImageMessageWidget({Key? key, required this.messageData, required this.isSender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ImageMessagePreview.routeName, arguments: messageData);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: messageData.text,
                maxHeightDiskCache: 380,
                fit: BoxFit.cover,
                // ignore: prefer_const_constructors
                placeholder: (context, url) => CircularProgressIndicator(),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: TimeSentMessageWidget(
                    isSender: isSender,
                    messageData: messageData,
                    colors: isSender ? kPrimaryColor : kGreyColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
