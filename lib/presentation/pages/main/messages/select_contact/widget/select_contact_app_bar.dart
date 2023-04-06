import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../../data/models/pop_up_menu_item_model.dart';
import '../../../../../../utils/styles/style.dart';
import '../../../../../bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';
import '../../../../../bloc/select_contact/getAllContact/get_all_contacts_state.dart';
import '../../../../../bloc/select_contact/getContactsNotOnApp/get_contacts_not_on_app_cubit.dart';
import '../../../../../bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import '../../../../../widget/custom_pop_up_menu_button.dart';

class SelectContactAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int numOfContacts;
  final GetAllContactsState state;

  const SelectContactAppBar(
      {Key? key, required this.numOfContacts, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select contact",
            style: context.headlineMedium?.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 3),
          Text(
            '$numOfContacts contacts',
            style: context.bodySmall?.copyWith(color: kPrimaryColor),
          ),
        ],
      ),
      actions: [
        if (state is GetAllContactsLoading)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: context.colorScheme.onPrimary,
                strokeWidth: 2,
              ),
            ),
          ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        CustomPopUpMenuButton(
            buttons: _buttons(context), colors: kPrimaryColor),
      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(BuildContext context) => [
        PopUpMenuItemModel(
          name: "Invite a friend",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "contacts",
          onTap: () {
            FlutterContacts.openExternalPick().then((value) {
              if (kDebugMode) {
                print(value!.displayName);
              }
            });
          },
        ),
        PopUpMenuItemModel(
          name: "Refresh",
          onTap: () {
            context.read<GetAllContactsCubit>().getAllContacts().then((value) {
              context.read<GetContactsOnAppCubit>().getContactsOnApp();
              context.read<GetContactsNotOnAppCubit>().getContactsNotOnApp();
            });
          },
        ),
        PopUpMenuItemModel(
          name: "Help",
          onTap: () {},
        ),
      ];

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
