import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/chat_contact_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/chat/contacts_chat_card.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';

import '../../../../../../../utils/helpers.dart';
import '../../../../../../bloc/message/message_contacts/chat_contacts_cubit.dart';
import '../../../../../../widget/custom_empty.dart';

class ContactsChatList extends StatelessWidget {
  const ContactsChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();

    return StreamBuilder<List<ChatContactModel>>(
      stream: context.read<MessageContactsCubit>().getChatContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading();
        }
        else{
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var chatContactData = snapshot.data![index];
                return ContactsChatCard(chatContactData: chatContactData);
              },
            );
          } else{
            return const CustomEmpty(text: "Messages Empty");
          }
        }
      },
    );
  }
}
