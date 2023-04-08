import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/widget/custom_pop_up_menu_button.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

import '../../../../../../../data/models/pop_up_menu_item_model.dart';
import '../../../../../../../utils/styles/style.dart';

class AppBarMessagePreview extends StatelessWidget implements PreferredSizeWidget{
  const AppBarMessagePreview({
    super.key,
    required this.messageData,
  });

  final MessageModel messageData;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: BackButton(color: kBlackColor),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            messageData.senderId,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kBlackColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          Text(
              "${messageData.timeSent.getChatDayTime} ${messageData.timeSent.getTimeSentAmPmMode}",
              style: TextStyle(fontSize: 12, color: kBlackColor)
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.star_border),
          color: kBlackColor,
        ),
        IconButton(
          onPressed: () {},
          color: kBlackColor,
          icon: const Icon(CupertinoIcons.arrow_turn_up_right),
        ),
        CustomPopUpMenuButton(
            buttons: _buttons(context),
            colors: kBlackColor
        )
      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
    PopUpMenuItemModel(
      name: "Edit",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "All media",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "Show in message",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "Share",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "Save",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "See in gallery",
      onTap: () {},
    ),
  ];

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
