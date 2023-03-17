import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/chats/widget/my_message_card.dart';
import 'package:ngandika_app/presentation/pages/main/chats/widget/sender_message_card.dart';

import '../../../../../utils/models_helper.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messagesList.length,
      padding: EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index){
        if (messagesList[index]["isMe"] == true) {
          return MyMessageCard(
              message: messagesList[index]["text"].toString(),
              date: messagesList[index]["time"].toString()
          );
        }
        return SenderMessageCard(
            message: messagesList[index]["text"].toString(),
            date: messagesList[index]["time"].toString()
        );
      },
    );
  }
}
