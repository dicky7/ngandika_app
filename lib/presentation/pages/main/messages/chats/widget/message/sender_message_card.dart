import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../../../../utils/styles/style.dart';
import '../../../../../../bloc/message/chat/chat_cubit.dart';
import '../message_content_type/message_content_type.dart';
import 'message_reply_card.dart';

class SenderMessageCard extends StatelessWidget {
  final MessageModel message;
  final int index;

  const SenderMessageCard({Key? key, required this.message, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = context.watch<ChatCubit>().selectedMessageIndex == index;
    //check repliedMessage is not empty
    final isReplying = message.repliedMessage.isNotEmpty;

    return SwipeTo(
      onRightSwipe: () {
        context.read<ChatCubit>().onMessageSwipe(
            message: message.text,
            isMe: false,
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
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: context.width(0.8),
                    minWidth: 120,
                    maxHeight: 400
                ),
                child: Card(
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.zero),
                  ),
                  color: context.watch<ChatCubit>().selectedMessageIndex == index
                        ? kBlue
                        : kPrimaryColor,
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if repliedMessage is not empty show MessageReplyCard
                        if (isReplying)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: MessageReplyCard(
                              isMe: message.repliedTo != message.senderName,
                              repliedTo: message.repliedTo,
                              text: message.repliedMessage,
                              repliedMessageType: message.repliedMessageType,

                            ),
                          ),
                        MessageContentType(
                            isSender: false,
                            messageData: message
                        ),
                      ],
                    )
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
