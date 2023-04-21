import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/presentation/pages/main/settings/my_profile_detail_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/settings/widget/my_profile_circle_detail.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class MyProfileDetailPage extends StatelessWidget {
  static const routeName = "profile-detail";
  final UserModel user;

  const MyProfileDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyProfileDetailAppBar(),
      body: Column(
        children: [
          MyProfileCircleDetail(),
          buildListTile(
              leading: Icons.person,
              title: "Name",
              subtitle: user.name,
              trailing: Icons.edit),
          buildListTile(
              leading: Icons.info_outline,
              title: "About",
              subtitle: user.status,
              trailing: Icons.edit),
          buildListTile(
            leading: Icons.call,
            title: "Phone",
            subtitle: user.phoneNumber,
          )
        ],
      ),
    );
  }

  Widget buildListTile({
    required IconData leading,
    required String title,
    required String subtitle,
    IconData? trailing}){
    return ListTile(
      leading: Icon(leading, color: kGreyColor, size: 30),
      title: Text(
        title,
        style: TextStyle(color: kGreyColor, fontWeight: FontWeight.w600, fontSize: 13),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: kBlackColor, fontWeight: FontWeight.w500, fontSize: 18),
      ),
      trailing: trailing != null ? Icon(trailing, color: kBlue) : const SizedBox(),
    );
  }

}
