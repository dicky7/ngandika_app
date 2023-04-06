import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/splash/on_boarding_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "splash";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      context.read<AuthCubit>().getCurrentUid().then((uId) {
        print("USER ID $uId");
        if (uId.isNotEmpty) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.routeName, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, OnBoardingPage.routeName, (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo_icon.png",
          height: 150,
        ),
      ),
    );
  }
}
