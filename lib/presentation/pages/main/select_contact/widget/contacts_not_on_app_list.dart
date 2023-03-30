import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsNotOnApp/get_contacts_not_on_app_cubit.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../utils/functions/app_dialogs.dart';
import '../../../../../utils/styles/style.dart';
import '../../../../widget/custom_list_tile.dart';

class ContactsNotOnAppList extends StatefulWidget {
  const ContactsNotOnAppList({Key? key}) : super(key: key);

  @override
  State<ContactsNotOnAppList> createState() => _ContactsNotOnAppListState();
}

class _ContactsNotOnAppListState extends State<ContactsNotOnAppList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<GetContactsNotOnAppCubit>().getContactsNotOnApp(),
      builder: (context, snapshot) {
        return BlocConsumer<GetContactsNotOnAppCubit, GetContactsNotOnAppState>(
          listener: (context, state) {
            if (state is GetContactsNotOnAppError) {
              AppDialogs.showCustomDialog(
                  context: context,
                  icons: Icons.close,
                  title: "Error",
                  content: state.message,
                  onPressed: () => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            if (state is GetContactsNotOnAppLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is GetContactsNotOnAppSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.contactsNotOnApp.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final contact = state.contactsNotOnApp[index];
                  return CustomListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundColor: kGreyColor,
                      child: Icon(
                        Icons.person_2_rounded,
                        color: kPrimaryColor,
                        size: 28,
                      ),
                    ),
                    title: contact.displayName,
                    titleButton: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Invite",
                        style: context.bodyLarge?.copyWith(color: kBlueLight, fontWeight: FontWeight.bold)
                      )
                    ),
                  );
                },
              );
            }else{
              debugPrint("$state");
              return SizedBox();
            }
          },
        );
      }
    );
  }
}
