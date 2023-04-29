import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/status/status_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/status/widget/status_list.dart';
import 'package:ngandika_app/presentation/pages/main/status/widget/status_app_bar.dart';
import 'package:ngandika_app/presentation/widget/custom_empty.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';

import '../../../../data/models/status_model.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const StatusAppBar(),
        body: BlocBuilder<StatusCubit, StatusState>(
          builder: (context, state) {
            return StreamBuilder<List<StatusModel>>(
                stream: context.read<StatusCubit>().getStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CustomLoading();
                  }
                  else{
                    if (snapshot.data!.isNotEmpty) {
                      return StatusList(status: snapshot.data!);
                    } else{
                      return const CustomEmpty(text: "Status Empty");
                    }
                  }
                });
          },
        ));
  }
}
