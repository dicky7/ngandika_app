import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsOnApp/get_contacts_on_app_state.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../../bloc/message/groups/groups_cubit.dart';
import '../../../../../bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';
import '../../../../../bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import '../../../../../widget/custom_list_tile.dart';
import '../../../../../widget/custom_network_image.dart';

class SelectContactGroup extends StatefulWidget {
  final  Map<String, dynamic> contactOnApp;
  const SelectContactGroup({Key? key, required this.contactOnApp}) : super(key: key);

  @override
  State<SelectContactGroup> createState() => _SelectContactGroupState();
}

class _SelectContactGroupState extends State<SelectContactGroup> {
  List<int> selectedContactsIndex = [];

  void selectContact(int index, String uIdContact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.removeAt(index);
    } else {
      selectedContactsIndex.add(index);
    }
    setState(() {});
    context.read<GroupsCubit>().selectContact(uIdContact);
  }

  @override
  void didChangeDependencies() {
    context.read<GroupsCubit>().selectedContactUId.clear();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: widget.contactOnApp.length,
          itemBuilder: (context, index) {
            final contact = widget.contactOnApp.values.toList()[index];
            return CustomListTile(
              onTap:() {},
              leading: CustomNetworkImage(
                imageUrl: contact["profilePicture"],
              ),
              title: contact["name"],
              subTitle: contact["status"],
              titleButton: selectedContactsIndex.contains(index)
                ? Icon(Icons.done, color: kBlueLight)
                : TextButton(
                  onPressed: () => selectContact(index, contact["uId"]),
                  child: Text(
                      "Invite",
                      style: context.bodyLarge?.copyWith(color: kBlueLight, fontWeight: FontWeight.bold)
                  )
              ),
            );
          },
        );
      },
    );
  }
}
