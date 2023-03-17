import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/chats/chat_page.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';

class AppRoutes{
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case ChatPage.routeName:
        return MaterialPageRoute(builder: (context) => ChatPage());
      default:
        return MaterialPageRoute(builder: (context) => const MainPage());
    }
  }
}