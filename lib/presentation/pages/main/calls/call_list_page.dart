import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/pages/main/calls/widget/call_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/calls/widget/call_card.dart';
import 'package:ngandika_app/presentation/widget/custom_empty.dart';

import '../../../../data/models/call_model.dart';
import '../../../bloc/call/call_cubit.dart';
import '../../../widget/custom_loading.dart';

class CallListPage extends StatelessWidget {
  const CallListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CallAppBar(),
      body: StreamBuilder<List<CallModel>>(
        stream: context.read<CallCubit>().getCallHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoading();
          }else{
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.only(bottom: 100, top: 8),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var callItem = snapshot.data![index];
                  return CallCard(callData: callItem);
                },
              );

            }else{
              return const CustomEmpty(text: "Calls Empty");
            }
          }
        },
      )
    );
  }
}
