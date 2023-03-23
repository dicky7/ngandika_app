import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/chats/chat_page.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/login_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/login_profile_info_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/on_boarding_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/splash_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/term_and_condition_page.dart';

import '../../presentation/pages/onboarding/login_otp_page.dart';

class AppRoutes{
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case OnBoardingPage.routeName:
        return MaterialPageRoute(builder: (context) => OnBoardingPage());
      case TermAndConditionPage.routeName:
        return MaterialPageRoute(builder: (context) => const TermAndConditionPage());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case LoginOtpPage.routeName:
        final phoneNumber =  settings.arguments as String;
        return MaterialPageRoute(builder: (context) => LoginOtpPage(
          phoneNumber: phoneNumber,
        ));
      case LoginProfileInfoPage.routeName:
        return MaterialPageRoute(builder: (context) => const LoginProfileInfoPage());
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case ChatPage.routeName:
        return MaterialPageRoute(builder: (context) => const ChatPage());
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}