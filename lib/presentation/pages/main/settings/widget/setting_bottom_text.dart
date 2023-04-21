import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';


class SettingBottomText extends StatelessWidget {
  const SettingBottomText({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 15),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'from\n',
              style: TextStyle(fontSize: 14, color: kGreyColor, fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: 'Ngandika | Dicky Angga',
              style: TextStyle(fontSize: 18, color: kBlue, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}