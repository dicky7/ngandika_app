import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/settings/widget/my_profile_detail_page.dart';
import 'package:ngandika_app/presentation/widget/custom_network_image.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../data/models/user_model.dart';
import '../../../../widget/custom_list_tile.dart';

class MyProfileCard extends StatelessWidget {
  const MyProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UpdateProfilePicSuccess) {
          context.read<UserCubit>().getCurrentUser();
        }
      },
      builder: (context, state) {
        UserModel? user = context.read<UserCubit>().userModel;

        return CustomListTile(
          onTap: () {
            Navigator.pushNamed(context, MyProfileDetailPage.routeName, arguments: user);
          },
          leading: Hero(
              tag: user!.uId,
              child: CustomNetworkImage(
                imageUrl: user.profilePicture,
                radius: 30,
              )
          ),
          title: user.name,
          subTitle: user.status,
          titleButton: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset("assets/qr_code.png")),
        );
      },
    );
  }
}
