import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/call_model.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

import '../../../../../utils/styles/style.dart';
import '../../../../bloc/user/user_cubit.dart';
import '../../../../widget/custom_network_image.dart';

class CallCard extends StatelessWidget {
  final CallModel callData;

  const CallCard({Key? key, required this.callData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentIdUser = context.read<UserCubit>().userModel!;
    return ListTile(
      onTap: () {},
      leading: CustomNetworkImage(
          imageUrl: callData.receiverPic,
          radius: 30,
        ),
      title: Text(
        callData.receiverName,
        style: Theme.of(context).textTheme.headlineSmall,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            currentIdUser.uId == callData.callerId
                ? Icon(Icons.call_made, color: kGreenColor, size: 20)
                : Icon(Icons.call_received, color: kRedColor, size: 20),
            const SizedBox(width: 5),
            Text(
              callData.timeCalling.getChatContactTime,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kGreyColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(CupertinoIcons.phone_fill, color: kGreenColor),
      ),
    );
  }
}
