import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getAllContact/get_all_contacts_state.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsNotOnApp/get_contacts_not_on_app_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/select_contact/widget/contacts_not_on_app_list.dart';
import 'package:ngandika_app/presentation/pages/main/select_contact/widget/contacts_on_app_list.dart';
import 'package:ngandika_app/presentation/pages/main/select_contact/widget/new_group_contact.dart';
import 'package:ngandika_app/presentation/pages/main/select_contact/widget/select_contact_app_bar.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../utils/functions/app_dialogs.dart';
import '../../../bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';

class SelectContactPage extends StatefulWidget {
  static const routeName = "select-contact";

  const SelectContactPage({Key? key}) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllContactsCubit>().getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          context.read<GetAllContactsCubit>().getAllContacts();
          return BlocConsumer<GetAllContactsCubit, GetAllContactsState>(
            listener: (context, state) {
              if (state is GetAllContactsError) {
                AppDialogs.showCustomDialog(
                    context: context,
                    icons: Icons.close,
                    title: "Error",
                    content: state.message,
                    onPressed: () => Navigator.pop(context));
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: SelectContactAppBar(
                  numOfContacts: context.watch<GetContactsOnAppCubit>().totalContacts + context.watch<GetContactsNotOnAppCubit>().totalContacts,
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NewGroupContact(),
                      titleText("Contacts on App"),
                      const ContactsOnAppList(),
                      titleText("Invite to Join Ngandika"),
                      const ContactsNotOnAppList(),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        text,
        style: context.titleMedium
            ?.copyWith(color: kGreyColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
