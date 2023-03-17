import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class BottomChatField extends StatelessWidget {
  const BottomChatField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          customChatField(context),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kBlue,
            ),
            width: 50,
            height: 50,
            child: Icon(
              Icons.send,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );

  }

  Widget customChatField(BuildContext context){
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
              onPressed: () {},
              icon: Icon(
                  Icons.emoji_emotions,
                  color: kGreyColor,
                size: 25,
              )
          ),
          Flexible(
            child: Scrollbar(
              child: TextField(
                // onChanged: onTextFieldValueChanged,
                // controller: messageController,
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.paperclip,
                color: kGreyColor,
                size: 25,
              )
          ),
        ],
      ),
    );
  }
}
