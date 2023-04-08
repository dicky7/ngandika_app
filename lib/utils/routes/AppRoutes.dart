import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/camera_page.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/image_preview_page.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/video_preview_page.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';

import '../../presentation/pages/main/messages/chats/chat_page.dart';
import '../../presentation/pages/main/messages/select_contact/select_contact_page.dart';
import '../../presentation/pages/onboarding/login/login_otp_page.dart';
import '../../presentation/pages/onboarding/login/login_page.dart';
import '../../presentation/pages/onboarding/login/login_profile_info_page.dart';
import '../../presentation/pages/onboarding/splash/on_boarding_page.dart';
import '../../presentation/pages/onboarding/splash/splash_page.dart';
import '../../presentation/pages/onboarding/splash/term_and_condition_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case OnBoardingPage.routeName:
        return MaterialPageRoute(builder: (context) => OnBoardingPage());
      case TermAndConditionPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const TermAndConditionPage());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case LoginOtpPage.routeName:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => LoginOtpPage(phoneNumber: phoneNumber));
      case LoginProfileInfoPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const LoginProfileInfoPage());
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case SelectContactPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const SelectContactPage());
      case ChatPage.routeName:
        final arguments = settings.arguments as ChatPage;
        return MaterialPageRoute(
            builder: (context) => ChatPage(
                  name: arguments.name,
                  receiverId: arguments.receiverId,
                ));
      case CameraPage.routeName:
        final arguments = settings.arguments as CameraPage;
        return MaterialPageRoute(
          builder: (context) => CameraPage(
              receiverId: arguments.receiverId,
              isCameraChat: arguments.isCameraChat));
      case ImagePreviewPage.routeName:
        final arguments = settings.arguments as ImagePreviewPage;
        return MaterialPageRoute(
          builder: (context) => ImagePreviewPage(
              isCameraChat: arguments.isCameraChat,
              imageFilePath: arguments.imageFilePath,
              receiverId: arguments.receiverId));
      case VideoPreviewPage.routeName:
        final arguments = settings.arguments as VideoPreviewPage;
        return MaterialPageRoute(
          builder: (context) => VideoPreviewPage(
              isCameraChat: arguments.isCameraChat,
              receiverId: arguments.receiverId,
              videoFilePath: arguments.videoFilePath));
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}
