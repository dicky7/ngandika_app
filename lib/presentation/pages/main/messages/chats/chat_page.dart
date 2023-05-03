import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/bottom_chat_field_icon.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/mic/recording_mic.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/chat_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message/messages_list.dart';

import '../../calls/calling/call_pickup_page.dart';

class ChatPage extends StatelessWidget {
  static const routeName = "chat";


  final String name;
  final String receiverId;
  final String profilePicture;
  final bool isGroupChat;

  const ChatPage({
    Key? key,
    required this.name,
    required this.receiverId,
    required this.isGroupChat,
    required this.profilePicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallPickupPage(
      scaffold: Scaffold(
        appBar: ChatAppBar(
            name: name,
            receiverId: receiverId,
            profilePicture: profilePicture,
            isGroupChat: isGroupChat,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(child: MessagesList(receiverId: receiverId, isGroupChat: isGroupChat)),
                BottomChatFieldIcon(receiverId: receiverId, isGroupChat: isGroupChat)
              ],
            ),
            RecordingMic(receiverId: receiverId, isGroupChat: isGroupChat)
          ],
        ),
      ),
    );
  }
}
