import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';

import '../../../../../../../utils/enums/message_type.dart';
import '../../../../../../../utils/styles/style.dart';

class MessageReplyCard extends StatelessWidget {
  final bool showCloseButton;
  final bool isMe;
  final bool isMessageCard;
  final String repliedTo;
  final String text;
  final MessageType repliedMessageType;


  const MessageReplyCard({
    Key? key,
    this.showCloseButton = false,
    this.isMessageCard = false,
    required this.isMe,
    required this.repliedTo,
    required this.text,
    required this.repliedMessageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isMessageCard ? Colors.grey.shade200 : Colors.black.withOpacity(0.03),
          border: Border(
            left: BorderSide(
              width: 5,
              color: isMe ? kBlue : kBlueLight
            )
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header reply message
            Row(
              children: [
                Expanded(
                  child: Text(
                    isMe ? "You" : repliedTo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? kBlueLight : kBlue
                    ),
                  ),
                ),
                if (showCloseButton)
                  GestureDetector(
                    onTap: () => context.read<ChatCubit>().cancelReplay(),
                    child: Icon(
                      Icons.clear,
                      size: 16,
                      color: kBlackColor,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            MessageReplyContent(repliedMessageType: repliedMessageType, text: text)
          ],
        ),
      ),
    );
  }
}

class MessageReplyContent extends StatelessWidget {
  final MessageType repliedMessageType;
  final String text;

  const MessageReplyContent({Key? key, required this.repliedMessageType, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (repliedMessageType) {
      case MessageType.text:
        return Text(
          text,
          style: const TextStyle(color: Colors.black38, fontSize: 14),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
      case MessageType.image:
        return Row(
          children: const [
            Icon(Icons.image, color: Colors.black38),
            SizedBox(width: 4),
            Text(
              'Photo',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.gif:
        return Row(
          children: const [
            Icon(Icons.gif),
            Text(
              'GIF',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.video:
        return Row(
          children: const [
            Icon(Icons.videocam),
            Text(
              'Video',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.audio:
        return Row(
          children: const [
            Icon(
              Icons.mic,
              size: 18,
              color: Colors.black38,
            ),
            Text(
              'Voice message',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      default:
        return Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
    }
  }
}

