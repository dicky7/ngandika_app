import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';

import '../../../../bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import '../../../../bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';
import '../../../../bloc/select_contact/getContactsOnApp/get_contacts_on_app_state.dart';

class ContactsOnAppList extends StatefulWidget {
  const ContactsOnAppList({Key? key}) : super(key: key);

  @override
  State<ContactsOnAppList> createState() => _ContactsOnAppListState();
}

class _ContactsOnAppListState extends State<ContactsOnAppList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<GetContactsOnAppCubit>().getContactsOnApp(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetContactsOnAppCubit, GetContactsOnAppState>(
      builder: (context, state) {
        if (state is GetContactsOnAppLoading) {
          return const Center(
              child: CircularProgressIndicator()
          );
        } else if (state is GetContactsOnAppSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.contactsOnApp.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final contact = state.contactsOnApp.values.toList()[index];
              return CustomListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: contact["profilePicture"],
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    fit: BoxFit.cover,
                    height: 44,
                    width: 44,
                  ),
                ),
                title: contact["name"],
                subTitle: contact["status"],
                onTap: () {  },
              );
            },
          );
        }else{
          debugPrint("$state");
          return Text("$state");
        }
      },
    );
  }
}
