import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/chat_contact_model.dart';
import 'package:ngandika_app/presentation/bloc/message/chat_contacts/chat_contacts_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/chat/contact_profile_profile_fialog.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';
import 'package:ngandika_app/presentation/widget/custom_network_image.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

import '../../../chats/chat_page.dart';

class ContactsChatCard extends StatelessWidget {
  final ChatContactModel chatContactData;

  const ContactsChatCard({
    super.key,
    required this.chatContactData,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: context
          .read<ChatContactsCubit>()
          .getNumOfMessageNotSeen(chatContactData.contactId),
      builder: (context, snapshot) {
        return CustomListTile(
          onTap: () {
            Navigator.pushNamed(context, ChatPage.routeName,
                arguments: ChatPage(
                    name: chatContactData.name,
                    receiverId: chatContactData.contactId));
          },
          leading: Hero(
            tag: chatContactData.name,
            child: InkWell(
                onTap: () => showContactProfileDialog(context),
                child: CustomNetworkImage(
                  imageUrl: chatContactData.profilePicture,
                  radius: 30,
                )),
          ),
          title: chatContactData.name,
          subTitle: chatContactData.lastMessage,
          time: chatContactData.timeSent.getChatContactTime,
          numOfMessageNotSeen: snapshot.data ?? 0,
        );
      },
    );
  }
}
