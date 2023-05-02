import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/data/models/status_model.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/camera_page.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/image_preview_page.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/video_preview_page.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/preview_message_content/image_message_preview.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/preview_message_content/video_message_preview.dart';
import 'package:ngandika_app/presentation/pages/main/messages/groups/create_group_page.dart';
import 'package:ngandika_app/presentation/pages/main/settings/widget/my_profile_detail_page.dart';

import '../../presentation/pages/main/messages/chats/chat_page.dart';
import '../../presentation/pages/main/messages/select_contact/select_contact_page.dart';
import '../../presentation/pages/main/status/status_detail_page.dart';
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
      case CreateGroupPage.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => CreateGroupPage(
            contactOnApp: arguments,
          ),
        );
      case ChatPage.routeName:
        final arguments = settings.arguments as ChatPage;
        return MaterialPageRoute(
            builder: (context) => ChatPage(
                  name: arguments.name,
                  receiverId: arguments.receiverId,
                  isGroupChat: arguments.isGroupChat,
                ));
      case ImageMessagePreview.routeName:
        final arguments = settings.arguments as MessageModel;
        return MaterialPageRoute(
          builder: (context) => ImageMessagePreview(messageData: arguments),
        );
      case VideoMessagePreview.routeName:
        final arguments = settings.arguments as MessageModel;
        return MaterialPageRoute(
          builder: (context) => VideoMessagePreview(messageData: arguments),
        );
      case CameraPage.routeName:
        final arguments = settings.arguments as CameraPage;
        return MaterialPageRoute(
          builder: (context) => CameraPage(
              receiverId: arguments.receiverId,
              userData: arguments.userData,
              isGroupChat: arguments.isGroupChat,
          ));
      case ImagePreviewPage.routeName:
        final arguments = settings.arguments as ImagePreviewPage;
        return MaterialPageRoute(
          builder: (context) => ImagePreviewPage(
              imageFilePath: arguments.imageFilePath,
              receiverId: arguments.receiverId,
              userData: arguments.userData,
              isGroupChat: arguments.isGroupChat,
          ));
      case VideoPreviewPage.routeName:
        final arguments = settings.arguments as VideoPreviewPage;
        return MaterialPageRoute(
          builder: (context) => VideoPreviewPage(
            receiverId: arguments.receiverId,
            videoFilePath: arguments.videoFilePath,
            userData: arguments.userData,
            isGroupChat: arguments.isGroupChat,
          ));
      case StatusDetailPage.routeName:
        final arguments = settings.arguments as StatusDetailPage;
        return MaterialPageRoute(
          builder: (context) => StatusDetailPage(
              status: arguments.status,
              myNumber: arguments.myNumber,
          ),
        );
      case MyProfileDetailPage.routeName:
        final arguments = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) => MyProfileDetailPage(user: arguments),
        );
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}
