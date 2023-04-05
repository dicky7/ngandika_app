
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import '../../presentation/pages/main/messages/chats/chat_page.dart';
import '../../presentation/pages/main/messages/select_contact/select_contact_page.dart';
import '../../presentation/pages/onboarding/login/login_otp_page.dart';
import '../../presentation/pages/onboarding/login/login_page.dart';
import '../../presentation/pages/onboarding/login/login_profile_info_page.dart';
import '../../presentation/pages/onboarding/splash/on_boarding_page.dart';
import '../../presentation/pages/onboarding/splash/splash_page.dart';
import '../../presentation/pages/onboarding/splash/term_and_condition_page.dart';

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
      case SelectContactPage.routeName:
        return MaterialPageRoute(builder: (context) => const SelectContactPage());
      case ChatPage.routeName:
        final arguments = settings.arguments as ChatPage;
        return MaterialPageRoute(builder: (context) => ChatPage(
          name: arguments.name,
          receiverId: arguments.receiverId,
        ));
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}