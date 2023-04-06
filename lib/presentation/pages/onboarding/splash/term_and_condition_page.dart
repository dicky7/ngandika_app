import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/onboarding/widgets/login_app_bar.dart';
import 'package:ngandika_app/presentation/widget/custom_button.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../login/login_page.dart';

class TermAndConditionPage extends StatelessWidget {
  static const routeName = "term-condition";

  const TermAndConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Welcome to Ngandika",
            style: context.headlineLarge?.copyWith(color: kBlue),
          ),
          const Spacer(),
          Image.asset(
            "assets/term_and_condition_bg.png",
            width: context.width(0.65),
            color: kBlue,
          ),
          const Spacer(),
          buildTermsService(context),
          const SizedBox(height: 20),
          CustomButton(
            text: "AGREE AND CONTINUE",
            color: kBlueLight,
            width: context.width(0.7),
            onPress: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget buildTermsService(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text.rich(
          //style: context.bodyMedium,
          style: context.titleMedium,
          textAlign: TextAlign.center,
          TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: "Read our ",
              ),
              buildTextSpanGreenButton(
                text: "Privacy Policy",
                onTap: () {
                  // code to open / launch terms of service link here
                },
                context: context,
              ),
              const TextSpan(
                text: '. Tap "Agree And Continue" to accept the ',
              ),
              buildTextSpanGreenButton(
                text: 'Terms of Service',
                onTap: () {
                  // code to open / launch terms of service link here
                },
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan buildTextSpanGreenButton({
    required String text,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return TextSpan(
      text: text,
      style: context.bodyMedium?.copyWith(color: kGreenColor),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
