import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ngandika_app/presentation/pages/main/calls/call_page.dart';
import 'package:ngandika_app/presentation/pages/main/contacts_chat/contacts_chat_page.dart';
import 'package:ngandika_app/presentation/pages/main/settings/setting_page.dart';
import 'package:ngandika_app/presentation/pages/main/status/status_page.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../bloc/main_page/page_cubit.dart';
import '../../widget/custom_buttom_navigation_item.dart';

class MainPage extends StatefulWidget {
  static const routeName = "main";
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                buildContent(state),
                customBottomBarNavigation()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildContent(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const ContactsChatPage();
      case 1:
        return const StatusPage();
      case 2:
        return const CallPage();
      case 3:
        return const SettingPage();
      default:
        return const ContactsChatPage();
    }
  }

  String buildTextAppBar(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return "Messages";
      case 1:
        return "Status";
      case 2:
        return "Calls";
      case 3:
        return "Settings";
      default:
        return "Messages";
    }
  }

  Widget customBottomBarNavigation() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 65,
        margin: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: kGreyColor.withOpacity(0.4), blurRadius: 5)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomBottomNavigationItem(
              index: 0,
              icons: CupertinoIcons.bubble_left_bubble_right_fill,
              text: "Messages",
            ),
            CustomBottomNavigationItem(
                index: 1,
                icons: Icons.camera,
              text: "Status",
            ),
            CustomBottomNavigationItem(
                index: 2,
                icons: CupertinoIcons.phone_fill,
              text: "Calls",
            ),
            CustomBottomNavigationItem(
                index: 3,
                icons: CupertinoIcons.settings,
              text: "Settings",
            )
          ],
        ),
      ),
    );
  }
}
