import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/status/widget/status_app_bar.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatusAppBar(),
      body: Text("status"),
    );
  }
}
