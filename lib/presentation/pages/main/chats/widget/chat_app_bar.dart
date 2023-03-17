import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/pop_up_menu_item_model.dart';
import '../../../../../utils/helpers.dart';
import '../../../../../utils/styles/style.dart';
import 'custom_pop_up_menu_button.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leadingWidth: 75,
      elevation: 3,
      leading: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const SizedBox(width: 5),
              Icon(
                Icons.arrow_back_ios_new,
                color: kBlackColor,
              ),
              const SizedBox(width: 5),
              Hero(
                tag: "userdata.uId",
                child: ClipOval(
                  child: CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: Helpers.randomPictureUrl(),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      title: SizedBox(
        width: double.infinity,
        height: kTextTabBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kBlackColor, fontWeight: FontWeight.bold),
            ),
            Text(
              "Online",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kGreyColor),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          splashRadius: 20,
          icon: Icon(Icons.videocam, color: kBlackColor),
        ),
        IconButton(
          onPressed: () {},
          splashRadius: 20,
          icon: Icon(Icons.call, color: kBlackColor),
        ),
        CustomPopUpMenuButton(
          buttons: _buttons(context),
        ),

      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
    PopUpMenuItemModel(
      name: "View Contact",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "Block",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "Search",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "Block Notification",
      onTap: () {},
    ),
    PopUpMenuItemModel(
      name: "More",
      onTap: () {},
    ),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
