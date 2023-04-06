import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class BottomChatField extends StatelessWidget {
  final VoidCallback toggleEmojiKeyboard;
  final bool isShowEmoji;
  final TextEditingController messageController;
  final Function(String) onTextFieldValueChanged;
  final FocusNode focusNode;
  final String receiverId;

  const BottomChatField(
      {Key? key,
      required this.messageController,
      required this.focusNode,
      required this.onTextFieldValueChanged,
      required this.isShowEmoji,
      required this.toggleEmojiKeyboard,
      required this.receiverId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 85,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: toggleEmojiKeyboard,
              color: kGreyColor,
              iconSize: 25,
              icon: Icon(isShowEmoji
                  ? Icons.keyboard_alt_outlined
                  : Icons.emoji_emotions)),
          Flexible(
            //The ConstrainedBox widget is used to set constraints on the size of its child widget, which is a Scrollbar widget.
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                maxWidth: double.infinity,
                minHeight: 25,
                maxHeight: 135,
              ),

              //The ConstrainedBox widget is used to set constraints on the size of its child widget, which is a Scrollbar widget.
              child: Scrollbar(
                child: TextField(
                  onChanged: onTextFieldValueChanged,
                  controller: messageController,
                  focusNode: focusNode,
                  cursorColor: kGreyColor,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(
                    fontSize: 20,
                    color: kBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: kGreyColor,
                      fontWeight: FontWeight.normal,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.paperclip,
                color: kGreyColor,
                size: 25,
              )),
        ],
      ),
    );
  }
}
