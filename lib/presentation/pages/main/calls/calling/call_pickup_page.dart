import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/data/models/call_model.dart';
import 'package:ngandika_app/presentation/bloc/call/call_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/calls/calling/calling_page.dart';
import 'package:ngandika_app/presentation/widget/custom_network_image.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class CallPickupPage extends StatelessWidget {

  final Widget scaffold;

  const CallPickupPage({Key? key, required this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CallModel>(
      stream: context.read<CallCubit>().callStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          CallModel call = snapshot.data!;

          // we receive incoming call
          if (!call.hasDialled) {
            return Scaffold(
              backgroundColor: kPrimaryColor,
              body: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Incoming Call',
                      style: context.titleLarge!.copyWith(color: kBlue, fontSize: 30),
                    ),
                    const SizedBox(height: 40),
                    CustomNetworkImage(
                      imageUrl: call.callerPic,
                      radius: 60,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      call.callerName,
                      style: context.headlineMedium!.copyWith(color: kBlue),
                    ),
                    const SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CallCubit>().endCall(
                              callerId: call.callId,
                              receiverId: call.receiverId,
                            );
                          },
                          icon: Icon(CupertinoIcons.phone_down_fill, color: kRedColor, size: 40),
                        ),
                        const SizedBox(width: 55),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                CallingPage.routeName,
                                arguments: CallingPage(
                                  channelId: call.callId,
                                  call: call,
                                  isGroupChat: false
                              )
                            );
                          },
                          icon: Icon(CupertinoIcons.phone_fill, color: kGreenColor, size: 40,),
                        )
                      ],
                    )
                  ],
                ),
              ),

            );
          }
        }
        return scaffold;
      },
    );
  }
}
