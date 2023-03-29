import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/select_contact_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/select_contact_state.dart';
import 'package:ngandika_app/presentation/pages/main/select_contact/select_contact_app_bar.dart';

import '../../../../utils/functions/app_dialogs.dart';

class SelectContactPage extends StatefulWidget {
  static const routeName = "select-contact";

  const SelectContactPage({Key? key}) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SelectContactCubit.get(context).getAllContacts().then((value) {
          SelectContactCubit.get(context).getContactsOnWhatsApp();
          SelectContactCubit.get(context).getContactsNotOnWhatsApp();
        });
        return BlocConsumer<SelectContactCubit, SelectContactState>(
          listener: (context, state) {
            if (state is SelectContactErrorState) {
              AppDialogs.showCustomDialog(
                  context: context,
                  icons: Icons.close,
                  title: "Error",
                  content: state.message,
                  onPressed: () => Navigator.pop(context));

            }
          },
          builder: (context, state) {
            SelectContactCubit cubit = SelectContactCubit.get(context);
            return Scaffold(
              appBar: SelectContactAppBar(
                numOfContacts: cubit.contactNotOnWhats.length,
              ),
            );
          },
        );
      },
    );
  }
}
