import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/settings/widget/my_profile_card.dart';
import 'package:ngandika_app/presentation/pages/main/settings/widget/setting_bottom_text.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../data/models/settings_model.dart';
import '../../../../utils/styles/style.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Setting",
          style: context.titleLarge?.copyWith(color: kGreyColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10, bottom: 100),
        physics: const BouncingScrollPhysics(),
        children: [
          const MyProfileCard(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Divider(color: Colors.black12, thickness: 1),
          ),
          ...List<Widget>.generate(
            _settingItems.length,
                (index) => CustomListTile(
                  leading: Icon(_settingItems[index].icon, size: 30),
                  title: _settingItems[index].title,
                  subTitle: _settingItems[index].subtitle,
                  onTap: _settingItems[index].onTap,
            ),
          ),
          const SettingBottomText()
        ],
      ),
    );
  }

  final List<SettingsModel> _settingItems = [
    SettingsModel(
      icon: Icons.key,
      onTap: () {},
      title: 'Account',
      subtitle: 'Security notifications, change number',
    ),
    SettingsModel(
      icon: Icons.privacy_tip,
      onTap: () {},
      title: 'Privacy',
      subtitle: 'Bloc contacts, disappearing messages',
    ),
    SettingsModel(
      icon: Icons.chat_sharp,
      onTap: () {},
      title: 'Chats',
      subtitle: 'Theme, wallpapers, chat history',
    ),
    SettingsModel(
      icon: Icons.notifications,
      onTap: () {},
      title: 'Notifications',
      subtitle: 'Message, group & call tones',
    ),
    SettingsModel(
      icon: Icons.data_usage,
      onTap: () {},
      title: 'Storage and data',
      subtitle: 'Network usage, auto download',
    ),
    SettingsModel(
      icon: Icons.language,
      onTap: () {},
      title: 'App language',
      subtitle: 'English',
    ),
    SettingsModel(
      icon: Icons.help_outline,
      onTap: () {},
      title: 'Help',
      subtitle: 'Help centre, contact us, privacy policy',
    ),
    SettingsModel(
      icon: Icons.help_outline,
      onTap: () {},
      title: 'Invite a friend',
      subtitle: '',
    ),
  ];


}
