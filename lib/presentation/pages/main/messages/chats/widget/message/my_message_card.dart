import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message/message_reply_card.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/message_content_type.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../../../bloc/message/chat/chat_cubit.dart';

class MyMessageCard extends StatelessWidget {
  final MessageModel message;
  final int index;

  const MyMessageCard({Key? key, required this.message, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = context.watch<ChatCubit>().selectedMessageIndex == index;
    //check repliedMessage is not empty
    final isReplying = message.repliedMessage.isNotEmpty;

    return SwipeTo(
      onRightSwipe: () {
        context.read<ChatCubit>().onMessageSwipe(
            message: message.text,
            isMe: true,
            messageType: message.messageType,
            repliedTo: message.senderName
        );
      },

      child: GestureDetector(
        onLongPress: () => context.read<ChatCubit>().updateIsPressed(index, message),
        onTap: () => context.read<ChatCubit>().clearSelectedIndex(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.width(0.8),
                  minWidth: 120,
                  maxHeight: 400,
                ),
                child: Card(
                  elevation: 1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.zero
                    ),
                  ),
                  color: isSelected ? kBlue : kBlueLight,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // if repliedMessage is not empty show MessageReplyCard
                      if (isReplying)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: MessageReplyCard(
                            isMessageCard: true,
                            isMe: message.repliedTo == message.senderName,
                            repliedTo: message.repliedTo,
                            text: message.repliedMessage,
                            repliedMessageType: message.repliedMessageType,

                          ),
                        ),
                      MessageContentType(messageData: message, isSender: true),
                    ],
                  ),
                ),
              ),
            ),

            if (isSelected) // Add a shadow or stacked container when selected
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kBlue.withOpacity(0.5),
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

}

