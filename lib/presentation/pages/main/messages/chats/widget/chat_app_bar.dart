import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/presentation/widget/custom_appbar_network_image.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

import '../../../../../../data/models/pop_up_menu_item_model.dart';
import '../../../../../../utils/styles/style.dart';
import '../../../../../bloc/message/chat/chat_cubit.dart';
import '../../../../../widget/custom_loading.dart';
import '../../../../../widget/custom_pop_up_menu_button.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String receiverId;

  ChatAppBar({Key? key, required this.name, required this.receiverId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: context.read<UserCubit>().getUserById(receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoading();
          }
          UserModel user = snapshot.data!;

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
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainPage.routeName, (route) => false);
                },
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: kBlackColor,
                    ),
                    const SizedBox(width: 5),
                    CustomAppbarNetworkImage(
                      imageUrl: user.profilePicture,
                    ),
                  ],
                ),
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: kBlackColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(
                  user.isOnline ? "Online" : user.lastSeen.getLastSeen,
                  style: user.isOnline
                      ? TextStyle(fontSize: 12, color: kBlueLight)
                      : TextStyle(fontSize: 10, color: kGreyColor)
                )
              ],
            ),
            actions: context.watch<ChatCubit>().isPressed 
              ? getIconOnPressed(context) 
              : getIconButtons(context)
          );
        });
  }
  

  List<Widget> getIconButtons(BuildContext context) {
    return [
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
        colors: kBlackColor,
      ),
    ];
  }

  List<Widget> getIconOnPressed(BuildContext context) {
    return [
      IconButton(
        onPressed: () {},
        splashRadius: 20,
        icon: Icon(Icons.delete, color: kBlackColor),
      ),
      IconButton(
        onPressed: () {},
        splashRadius: 20,
        icon: Icon(Icons.star_border, color: kBlackColor),
      ),
      IconButton(
        onPressed: () {},
        splashRadius: 20,
        icon: Icon(CupertinoIcons.arrow_turn_up_right, color: kBlackColor),
      ),
      CustomPopUpMenuButton(
        buttons: _buttons(context),
        colors: kBlackColor,
      ),
    ];
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
