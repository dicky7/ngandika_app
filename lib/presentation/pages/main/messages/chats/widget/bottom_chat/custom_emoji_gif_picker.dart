import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

class CustomEmojiGifPicker extends StatelessWidget {
  final TextEditingController messageController;

  const CustomEmojiGifPicker({Key? key, required this.messageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: EmojiPicker(
        onBackspacePressed: () => messageController.text.trimRight(),
        textEditingController: messageController,
        config: Config(
          columns: 8,
          iconColorSelected: context.colorScheme.secondary,
          indicatorColor: context.colorScheme.secondary,
          backspaceColor: Colors.black26,
        ),
      ),
    );
  }
}