import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/chat/contacts_chat_list.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/stories/contacts_chat_stories.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/contact_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/chat/contact_profile_profile_fialog.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';
import 'package:ngandika_app/presentation/widget/custom_network_image.dart';

import '../../../../../utils/helpers.dart';
import '../../../../../utils/models_helper.dart';
import '../chats/chat_page.dart';

class ContactsChatPage extends StatelessWidget {
  const ContactsChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContactAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ContactsChatStories(), 
          ContactsChatList()
        ],
      ),
    );
  }
}

