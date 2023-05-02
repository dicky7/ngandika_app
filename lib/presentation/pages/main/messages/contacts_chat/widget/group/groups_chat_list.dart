import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/group_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/contacts_chat/widget/group/groups_chat_card.dart';

import '../../../../../../bloc/message/message_groups/message_groups_cubit.dart';
import '../../../../../../widget/custom_loading.dart';

class GroupsChatList extends StatelessWidget {
  const GroupsChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GroupModel>>(
      stream: context.read<MessageGroupsCubit>().getChatGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading();
        }
        else{
          if (snapshot.data != null) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100, top: 10, left: 2, right: 2),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var groupData = snapshot.data![index];
                return GroupsChatCard(groupData: groupData);
              },
            );
          } else{
            return const SizedBox();
          }
        }
      },
    );
  }
}
