import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/settings/widget/my_profile_detail_page.dart';
import 'package:ngandika_app/presentation/widget/custom_appbar_network_image.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/functions/app_dialogs.dart';

import '../../../../../../utils/styles/style.dart';
import '../../../cameras/camera_page.dart';
import '../../select_contact/select_contact_page.dart';

class ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  ContactAppBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserCubit>().getCurrentUser(),
      builder: (context, snapshot) {
        UserModel? user = context.read<UserCubit>().userModel;
        if (user != null) {
          return AppBar(
            backgroundColor: kPrimaryColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Messages",
              style: context.titleLarge?.copyWith(color: kGreyColor),
            ),
            leadingWidth: 54,
            leading: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyProfileDetailPage.routeName, arguments: user);
                  },
                  child: Hero(
                    tag: user.uId,
                    child: CustomAppbarNetworkImage(
                      imageUrl: user.profilePicture,
                    ),
                  ),
                )
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.camera_alt, color: kBlackColor),
                onPressed: () {
                  Navigator.pushNamed(context, CameraPage.routeName, arguments: CameraPage(
                    userData: user,
                    isGroupChat: false,
                  ));
                },
              ),
              IconButton(
                icon: Icon(Icons.note_alt_outlined, color: kBlackColor),
                onPressed: () {
                  Navigator.pushNamed(context, SelectContactPage.routeName);
                },
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
