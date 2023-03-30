import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getAllContact/get_all_contacts_state.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';

import '../../../../../utils/functions/app_dialogs.dart';
import '../../../../bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import '../../../../bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';
import '../../../../bloc/select_contact/getContactsOnApp/get_contacts_on_app_state.dart';

class ContactsOnAppList extends StatelessWidget {
  const ContactsOnAppList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<GetContactsOnAppCubit>().getContactsOnApp(),
      builder: (context, snapshot) {
        return BlocConsumer<GetContactsOnAppCubit, GetContactsOnAppState>(
          listener: (context, state) {
            if (state is GetContactsOnAppError) {
              AppDialogs.showCustomDialog(
                  context: context,
                  icons: Icons.close,
                  title: "Error",
                  content: state.message,
                  onPressed: () => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            if (state is GetAllContactsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is GetContactsOnAppSuccess) {
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
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        fit: BoxFit.cover,
                        height: 44,
                        width: 44,
                      ),
                    ),
                    title: contact["name"],
                    subTitle: contact["status"],
                    onTap: () {},
                  );
                },
              );
            } else{
              debugPrint("$state");
              return SizedBox();
            }
          },
        );
      }
    );
  }
}
