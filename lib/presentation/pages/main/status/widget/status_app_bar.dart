import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/camera_page.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../data/models/pop_up_menu_item_model.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../utils/styles/style.dart';
import '../../../../bloc/user/user_cubit.dart';
import '../../../../widget/custom_pop_up_menu_button.dart';

class StatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserCubit>().getCurrentUser(),
      builder: (context, snapshot) {
        UserModel user = context.read<UserCubit>().userModel!;
        return AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 2,
          centerTitle: true,
          leadingWidth: 54,
          leading: IconButton(
            icon: Icon(Icons.camera_alt, color: kBlackColor),
            onPressed: () {
              Navigator.pushNamed(context, CameraPage.routeName, arguments: CameraPage(
                userData: user,
                isGroupChat: false,
              ));
            },
          ),
          title: Text(
            "Stories",
            style: context.titleLarge?.copyWith(color: kGreyColor),
          ),
          actions: [
            CustomPopUpMenuButton(
              buttons: _buttons(context),
              colors: kBlackColor,
            ),
          ],
        );
      },
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: "Status privacy",
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
