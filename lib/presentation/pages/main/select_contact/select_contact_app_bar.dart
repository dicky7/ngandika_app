import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../data/models/pop_up_menu_item_model.dart';
import '../../../bloc/select_contact/select_contact_state.dart';
import '../chats/widget/custom_pop_up_menu_button.dart';

class SelectContactAppBar extends StatelessWidget implements PreferredSizeWidget{
  final int numOfContacts;
  const SelectContactAppBar({Key? key, required this.numOfContacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select contact",
            style: context.headlineLarge,
          ),
          const SizedBox(height: 3),
          Text(
            '$numOfContacts contacts',
            style: context.bodySmall,
          ),
        ],
      ),
      actions: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: kBlueDark,
                strokeWidth: 2,
              ),
            ),
          ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        CustomPopUpMenuButton(buttons: _buttons(context)),
      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
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
