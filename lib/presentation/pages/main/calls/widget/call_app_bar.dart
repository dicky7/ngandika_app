import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/camera_page.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../data/models/pop_up_menu_item_model.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../utils/styles/style.dart';
import '../../../../bloc/user/user_cubit.dart';
import '../../../../widget/custom_pop_up_menu_button.dart';

class CallAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CallAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 2,
      centerTitle: true,
      title: Text(
        "Calls",
        style: context.titleLarge?.copyWith(color: kGreyColor),
      ),
      actions: [
        CustomPopUpMenuButton(
          buttons: _buttons(context),
          colors: kBlackColor,
        ),
      ],
    );;
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: "Clear Call Log",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "Settings",
          onTap: () {},
        ),
      ];

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
