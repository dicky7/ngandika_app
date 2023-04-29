import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/chat/contacts_chat_list.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/contact_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/group/groups_chat_list.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/stories/contacts_chat_stories.dart';

class ContactsChatPage extends StatelessWidget {
  const ContactsChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ContactsChatStories(),
          ContactsChatList(),
          GroupsChatList(),
        ],
      ),
    );
  }
}
