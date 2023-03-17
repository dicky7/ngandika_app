import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../../data/models/pop_up_menu_item_model.dart';

class CustomPopUpMenuButton extends StatelessWidget {
  final List<PopUpMenuItemModel> buttons;

  const CustomPopUpMenuButton({Key? key, required this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: kBlackColor),
      onSelected: (value) {
        buttons[value].onTap();

      },
      itemBuilder: (context) {
        return buttons.map((value){
          int index = buttons.indexOf(value);
          return PopupMenuItem(
            value: index,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(value.name),
            ),
          );
        }).toList();

      },
    );
  }
}
