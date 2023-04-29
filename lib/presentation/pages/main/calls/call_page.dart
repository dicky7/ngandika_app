import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/calls/widget/call_app_bar.dart';
import 'package:ngandika_app/presentation/widget/custom_empty.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CallAppBar(),
      body: CustomEmpty(text: "Calls Empty"),

    );
  }
}
