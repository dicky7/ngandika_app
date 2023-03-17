import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/chats/widget/bottom_chat_field.dart';
import 'package:ngandika_app/presentation/pages/main/chats/widget/chat_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/chats/widget/custom_pop_up_menu_button.dart';
import 'package:ngandika_app/presentation/pages/main/chats/widget/messages_list.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../utils/helpers.dart';

class ChatPage extends StatelessWidget {
  static const routeName = "chat";
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(),
      bottomNavigationBar: BottomChatField(),
      body: MessagesList(),
    );
  }

}
