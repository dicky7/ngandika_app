import 'package:flutter/material.dart';

import '../../../../../widget/custom_list_tile.dart';
import '../../../../../widget/custom_network_image.dart';
import '../../chats/chat_page.dart';

class ContactsOnAppList extends StatelessWidget {
  final Map<String, dynamic> contactsOnApp;

  const ContactsOnAppList({Key? key, required this.contactsOnApp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contactsOnApp.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final contact = contactsOnApp.values.toList()[index];
        print("uId : ${contact["uId"]}");
        return CustomListTile(
          leading: CustomNetworkImage(
            imageUrl: contact["profilePicture"],
          ),
          title: contact["name"],
          subTitle: contact["status"],
          onTap: () {
            Navigator.pushNamed(context, ChatPage.routeName,
                arguments: ChatPage(
                    name: contact["name"],
                    receiverId: contact["uId"],
                    profilePicture: contact['profilePicture'],
                    isGroupChat: false,
                ));
          },
        );
      },
    );
  }
}
