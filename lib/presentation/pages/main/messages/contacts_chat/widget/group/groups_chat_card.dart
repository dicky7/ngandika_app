import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/group_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/group/group_profil_dialog.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

import '../../../../../../widget/custom_list_tile.dart';
import '../../../../../../widget/custom_network_image.dart';
import '../../../chats/chat_page.dart';

class GroupsChatCard extends StatelessWidget {
  final GroupModel groupData;
  
  const GroupsChatCard({Key? key, required this.groupData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        Navigator.pushNamed(context, ChatPage.routeName,
            arguments: ChatPage(
                name: groupData.name,
                receiverId: groupData.groupId
            )
        );
      },
      leading: Hero(
        tag: groupData.name,
        child: InkWell(
            onTap: () => showGroupProfileDialog(context, groupData),
            child: CustomNetworkImage(
              imageUrl: groupData.groupProfilePic,
              radius: 30,
            )),
      ),
      title: groupData.name,
      subTitle: groupData.lastMessage,
      time: groupData.timeSent.getChatContactTime,
    );
  }
}
