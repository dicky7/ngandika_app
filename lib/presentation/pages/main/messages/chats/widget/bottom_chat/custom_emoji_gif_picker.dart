import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/message/bottom_chat/bottom_chat_cubit.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class CustomEmojiGifPicker extends StatelessWidget {
  final TextEditingController messageController;
  final bool isShowSendButton;
  final VoidCallback onGifButtonTap;

  const CustomEmojiGifPicker(
      {Key? key,
      required this.messageController,
      required this.isShowSendButton,
      required this.onGifButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EmojiPicker(
            onEmojiSelected: (category, emoji) {
              if (!isShowSendButton) {
                context.read<BottomChatCubit>().emojiSelectedShowButton();
              }
            },
            onBackspacePressed: () => messageController.text.trimRight(),
            textEditingController: messageController,
            config: Config(
              columns: 8,
              iconColorSelected: context.colorScheme.secondary,
              indicatorColor: context.colorScheme.secondary,
              backspaceColor: Colors.black26,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.gif_box_outlined),
            color: kBlackColor,
            iconSize: 40,
            onPressed: onGifButtonTap,
          )
        ],
      )
    );
  }
}
