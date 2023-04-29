import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/status/status_cubit.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/status/status_detail_page.dart';
import 'package:ngandika_app/presentation/pages/main/status/widget/glowing_avatar.dart';
import 'package:ngandika_app/presentation/pages/main/status/widget/status_app_bar.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

import '../../../../../data/models/status_model.dart';
import '../../../../widget/custom_list_tile.dart';

class StatusList extends StatelessWidget {
  final List<StatusModel> status;

  const StatusList({super.key, required this.status,});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      shrinkWrap: true,
      itemCount: status.length,
      itemBuilder: (context, index) {
        var statusData = status[index];
        var myNumber = context.read<UserCubit>().userModel?.phoneNumber;

        return CustomListTile(
          leading: Hero(
              tag: statusData.uId,
              child: GlowingAvatar(
                imageUrl: statusData.photoUrl.last,
                radius: 30,
              )),
          title: statusData.phoneNumber == myNumber
              ? "My Status"
              : statusData.username,
          subTitle: statusData.createdAt.getStatusTime24HoursMode,
          onTap: () {
            Navigator.pushNamed(context, StatusDetailPage.routeName,
                arguments:
                    StatusDetailPage(status: statusData, myNumber: myNumber!));
          },
        );
      },
    );
  }
}
