import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ngandika_app/presentation/pages/onboarding/login_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/widgets/login_app_bar.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../utils/functions/app_dialogs.dart';
import '../../../utils/styles/style.dart';
import 'login_profile_info_page.dart';

class LoginOtpPage extends StatefulWidget {
  static const routeName = "otp";
  final String phoneNumber;

  const LoginOtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(
        title: Text(
          'Verifying Your Number',
          style: TextStyle(color: kBlue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Waiting to automatically detect an sms sent to",
              style: context.bodyLarge,
            ),
            buildTextWrongNumber(context),
            buildPinCode(context),
            buildResendSms(context)
          ],
        ),
      ),
    );
  }

  Widget buildTextWrongNumber(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Text(
          widget.phoneNumber,
          style: context.bodyMedium?.copyWith(
              color: kBlackColor, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, LoginPage.routeName),
          child: const Text("Wrong number?"),
        )
      ],
    );
  }

  Widget buildPinCode(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthVerifyOtpSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, LoginProfileInfoPage.routeName, (route) => false);
        }else if(state is AuthError){
          AppDialogs.showCustomDialog(
              context: context,
              icons: Icons.close,
              title: "Error",
              content: state.message,
              onPressed: () => Navigator.pop(context)
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            width: context.width(0.45),
            child: PinFieldAutoFill(
              codeLength: 6,
              cursor: Cursor(
                  color: kBlue,
                  enabled: true,
                  height: 30,
                  width: 2
              ),
              onCodeChanged: (value) {
                if (value!.length == 6) {
                  context.read<AuthCubit>().verifyOtp(value.trim());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 25),
            child: Text(
              "Enter 6-digit code",
              style: context.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResendSms(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.message, color: kGreyColor),
        const SizedBox(width: 15),
        Text(
          "Resend SMS",
          style: TextStyle(color: kGreyColor),
        ),
        const Spacer(),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: const Duration(seconds: 60),
          onEnd: () {},
          builder: (context, value, child) {
            return Text(
              "00:${value.toInt()}",
              style: const TextStyle(color: Colors.grey),
            );
          },
        )
      ],
    );
  }
}
