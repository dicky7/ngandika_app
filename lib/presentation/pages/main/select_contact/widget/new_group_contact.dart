import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class NewGroupContact extends StatelessWidget {
  const NewGroupContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          leading: CircleAvatar(
            backgroundColor: context.colorScheme.secondary,
            child: Icon(
              Icons.group,
              color: kPrimaryColor,
            ),
          ),
          title: "New group",
          onTap: () {},
        ),
        CustomListTile(
          onTap: () {
            FlutterContacts.openExternalInsert();
          },
          leading: CircleAvatar(
            backgroundColor: context.colorScheme.secondary,
            child: Icon(
              Icons.person_add,
              color: kPrimaryColor,
            ),
          ),
          title: "New contact",
          titleButton: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset("assets/qr_code.png")
          ),
        ),

      ],
    );
  }
}
