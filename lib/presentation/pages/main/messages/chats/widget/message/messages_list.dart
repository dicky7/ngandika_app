import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message/sender_message_card.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message/tag_chat_time.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';

import '../../../../../../../utils/functions/date_converter.dart';
import '../../../../../../../utils/models_helper.dart';
import 'my_message_card.dart';

class MessagesList extends StatefulWidget {
  final String receiverId;
  final bool isGroupChat;

  const MessagesList({Key? key, required this.receiverId, required this.isGroupChat}) : super(key: key);

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController messageScrollController = ScrollController();

  @override
  void dispose() {
    messageScrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
      stream: widget.isGroupChat
          ? context.read<ChatCubit>().getGroupChatStream(widget.receiverId)
          : context.read<ChatCubit>().getChatStream(widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading();
        }

        //this code is used to automatically scroll to the bottom of a scrollable widget, after the widget has finished rendering its content.
        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageScrollController.jumpTo(messageScrollController.position.maxScrollExtent);
        });

        return ListView.builder(
          controller: messageScrollController,
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (context, index) {
            var messageData = snapshot.data![index];

            //set chat message seen
            // if message not seen and receiver not equal the update seen to true because we already in listview or open the chat
            if(!messageData.isSeen && widget.receiverId != messageData.receiverId){
              context.read<ChatCubit>().setMessageSeen(widget.receiverId, messageData.messageId);
            }
            return Column(
              children: [
                //If the message is the first one in the list or if it was sent on a different day than the previous message, a TagChatTime widget should be displayed.
                if (index == 0 || !DateConverter.getIsSameDay(messageData.timeSent, snapshot.data![index - 1].timeSent))
                  TagChatTime(dateTime: messageData.timeSent),

                if (messageData.receiverId == widget.receiverId)
                  MyMessageCard(message: messageData, index: index),

                if (messageData.receiverId != widget.receiverId)
                  SenderMessageCard(message: messageData, index: index)
              ],
            );
          },
        );
      },
    );
  }
}
