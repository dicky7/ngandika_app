import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/chat_contact_model.dart';
import 'package:ngandika_app/data/models/group_model.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/helpers.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../chats/chat_page.dart';

Future<void> showGroupProfileDialog(BuildContext context, GroupModel groupData) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Stack(
          children: [
            //this for show photo
            Hero(
              tag: groupData.name,
              child: CachedNetworkImage(
                imageUrl: groupData.groupProfilePic,
                height: 300,
                width: 400,
                fit: BoxFit.cover,
                placeholder: (context, url) => Stack(
                  children: [
                    Image.asset("assets/user_default.png"),
                    const Center(child: CircularProgressIndicator())
                  ],
                ),
                errorWidget: (context, url, error) => Image.asset("assets/user_default.png"),
              ),
            ),

            //this for show contacts name
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black26,
                child: Text(
                  groupData.name,
                  style: context.bodyLarge?.copyWith(color: kPrimaryColor),
                ),
              ),
            )
          ],
        ),

        //this for showing action
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              color: kBlueDark,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: kBlueDark,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.info_outline_rounded,
              color: kBlueDark,
              size: 25,
            ),
          ),
        ],
      );
    },
  );
}
