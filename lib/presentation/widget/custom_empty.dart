import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class CustomEmpty extends StatelessWidget {
  final String text;
  const CustomEmpty({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
              "assets/empty.json",
              height: 350),
          Text(
            text,
            style: context.titleLarge?.copyWith(color: kGreyColor),
          )
        ],
      ),
    );
  }
}
