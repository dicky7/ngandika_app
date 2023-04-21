import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/status/status_cubit.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/status/status_detail_page.dart';
import 'package:ngandika_app/presentation/pages/main/status/widget/glowing_avatar.dart';
import 'package:ngandika_app/presentation/pages/main/status/widget/status_app_bar.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../data/models/status_model.dart';
import '../../../../utils/functions/app_dialogs.dart';
import '../../../widget/custom_list_tile.dart';
import '../../../widget/custom_network_image.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatusAppBar(),
      body: StreamBuilder<List<StatusModel>>(
          stream: context.read<StatusCubit>().getStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoading();
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var statusData = snapshot.data![index];
                var myNumber = context.read<UserCubit>().userModel?.phoneNumber;

                return CustomListTile(
                  leading: Hero(
                      tag: statusData.uId,
                      child: GlowingAvatar(
                        imageUrl: statusData.photoUrl.last,
                        radius: 30,

                      )
                  ),
                  title: statusData.phoneNumber == myNumber
                      ? "My Status"
                      : statusData.username,
                  subTitle: statusData.createdAt.getStatusTime24HoursMode,
                  onTap: () {
                    Navigator.pushNamed(context, StatusDetailPage.routeName, arguments: StatusDetailPage(
                        status: statusData, myNumber: myNumber!));
                  },
                );
              },
            );
          }
      ),
    );
  }
}
