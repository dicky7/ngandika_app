import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/message/bottom_chat/bottom_chat_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/bottom_chat_field.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/custom_emoji_gif_picker.dart';

import '../../../../../../../utils/styles/style.dart';

class BottomChatFieldIcon extends StatelessWidget {
  final String receiverId;

  BottomChatFieldIcon({Key? key, required this.receiverId}) : super(key: key);

  final TextEditingController messageController =
      TextEditingController(text: "");
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final cubitRead = context.read<BottomChatCubit>();
    final cubitWatch = context.watch<BottomChatCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              BottomChatField(
                receiverId: receiverId,
                isShowEmoji: false,
                focusNode: focusNode,
                messageController: messageController,
                toggleEmojiKeyboard: () {},
                onTextFieldValueChanged: (value) =>
                    cubitRead.showSendButton(value),
              ),
              // if (cubit.isShowSendButton)
              buildButtonSend(context, cubitWatch.isShowSendButton)
            ],
          ),
        ),

        //this for show emoji EmojiPicker and Gif
        Offstage(
          offstage: true,
          child: CustomEmojiGifPicker(
            messageController: messageController,
          ),
        )
      ],
    );
  }

  Widget buildButtonSend(BuildContext context, bool isShowSendButton) {
    return GestureDetector(
      onTap: () {
        if (isShowSendButton) {
          context.read<ChatCubit>().sendTextMessage(
              text: messageController.text.trim(), receiverId: receiverId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kBlue,
        ),
        width: 50,
        height: 50,
        child: Icon(
          isShowSendButton ? Icons.send : Icons.mic,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
