import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/settings/widget/update_profile_bottomsheet.dart';
import 'package:ngandika_app/presentation/widget/custom_network_image.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class MyProfileCircleDetail extends StatelessWidget {
  const MyProfileCircleDetail({
    super.key,
  });

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
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          alignment: Alignment.center,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  showUpdateProfilePictureBottomSheet(context);
                },
                child: Hero(
                  tag: user!.uId,
                  child: CustomNetworkImage(
                    imageUrl: user.profilePicture,
                    radius: 85,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: kBlue,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_rounded),
                    color: Colors.white,
                    onPressed: () {
                      showUpdateProfilePictureBottomSheet(context);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
