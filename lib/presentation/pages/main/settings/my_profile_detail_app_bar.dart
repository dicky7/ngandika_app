import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../utils/styles/style.dart';

class MyProfileDetailAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyProfileDetailAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 2,
      title: Text(
        "Profile",
        style: context.titleLarge?.copyWith(color: kGreyColor),
      ),
      leading: BackButton(
        color: kGreyColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
