import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/bottom_chat_field_icon.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/chat_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message/messages_list.dart';

class ChatPage extends StatelessWidget {
  static const routeName = "chat";

  final String name;
  final String receiverId;

  const ChatPage({Key? key, required this.name, required this.receiverId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(name: name, receiverId: receiverId),
      body: Column(
        children: [
          Expanded(child: MessagesList(receiverId: receiverId)),
          BottomChatFieldIcon(receiverId: receiverId)
        ],
      ),
    );
  }
}
