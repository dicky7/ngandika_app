import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/chats/chat_page.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/on_boarding_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/splash_page.dart';

class AppRoutes{
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case OnBoardingPage.routeName:
        return MaterialPageRoute(builder: (context) => OnBoardingPage());
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case ChatPage.routeName:
        return MaterialPageRoute(builder: (context) => const ChatPage());
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}