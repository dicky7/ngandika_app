import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/widget/custom_appbar_network_image.dart';
import 'package:ngandika_app/presentation/widget/custom_network_image.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/functions/app_dialogs.dart';

import '../../../../../utils/styles/style.dart';
import '../../select_contact/select_contact_page.dart';

class ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Messages",
        style: context.titleLarge?.copyWith(color: kGreyColor),
      ),
      leadingWidth: 54,
      leading: Align(
        alignment: Alignment.centerRight,
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              AppDialogs.showCustomDialog(
                  context: context,
                  icons: Icons.close,
                  title: "Error",
                  content: state.message,
                  onPressed: () => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            if (state is GetCurrentUserSuccess) {
              return CustomAppbarNetworkImage(
                imageUrl: state.userModel.profilePicture,
              );
            } else {
              print(state.toString());
              return Container();
            }
          },
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: kBlackColor),
          onPressed: () {},
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
