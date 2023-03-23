import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/onboarding/widgets/login_app_bar.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../utils/styles/style.dart';

class LoginProfileInfoPage extends StatelessWidget {
  static const routeName = "profile-info";
  const LoginProfileInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(
        title: Text(
            "Profile info",
            style: TextStyle(color: kBlue)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please provide your name and an optional profile photo",
              style: context.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            buildProfilePicture(context)

          ],
        ),
      ),
    );
  }

  Widget buildProfilePicture(BuildContext context){
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: kGreyColor,
          child: Icon(
            Icons.person,
            color: kPrimaryColor,
            size: 65,
          ),
        ),
        Positioned(
          bottom: -10,
          right: 1,
          child: CircleAvatar(
            backgroundColor: kBlue,
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                color: kPrimaryColor,
                size: 20,
              ),
              onPressed: () {

              },
            ),
          ),
        )

      ],
    );
  }
}
