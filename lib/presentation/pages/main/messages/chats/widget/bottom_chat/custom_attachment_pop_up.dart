import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/camera_page.dart';

import '../../../../../../../utils/functions/image_griphy_picker.dart';
import '../../../../../../../utils/styles/style.dart';
import '../../../../cameras/widget/preview/image_preview_page.dart';

class CustomAttachmentPopUp extends StatelessWidget {
  final String receiverId;
  final bool isGroupChat;

  const CustomAttachmentPopUp({Key? key, required this.receiverId, required this.isGroupChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: RotationTransition(
        turns: const AlwaysStoppedAnimation(-45 / 360),
        child: Icon(
          CupertinoIcons.paperclip,
          color: kGreyColor,
          size: 25,
        ),
      ),
      //this allows you to specify the position of the popup menu relative to its anchor point
      offset: const Offset(0, -250),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      constraints: const BoxConstraints.tightFor(width: double.infinity),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
            enabled: false,
            onTap: () {},
            child: Wrap(
              spacing: 8,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                AttachmentCardItem(
                  name: "Document",
                  color: Colors.deepPurpleAccent,
                  icon: Icons.insert_drive_file,
                  onPress: () {},
                ),
                AttachmentCardItem(
                  name: "Camera",
                  color: Colors.redAccent,
                  icon: Icons.camera_alt,
                  onPress: () {
                    Navigator.pushNamed(
                        context,
                        CameraPage.routeName,
                        arguments: CameraPage(
                          receiverId: receiverId,
                          isGroupChat: isGroupChat,
                        ));
                  },
                ),
                AttachmentCardItem(
                  name: "Gallery",
                  color: Colors.purpleAccent,
                  icon: Icons.photo,
                  onPress: () {
                    selectImageFromGallery(context);
                  },
                ),
                AttachmentCardItem(
                  name: "Audio",
                  color: Colors.orange,
                  icon: Icons.headphones,
                  onPress: () {},
                ),
                AttachmentCardItem(
                  name: "Contact",
                  color: Colors.blue,
                  icon: Icons.person,
                  onPress: () {
                    FlutterContacts.openExternalPick();
                    Navigator.pop(context); // Close the popup menu
                  }
                )
              ],
            ),
          )
        ];
      },
    );
  }

  // This  function that selects an image from the device's gallery,
  void selectImageFromGallery(BuildContext context) async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      Navigator.pushNamed(
          context,
          ImagePreviewPage.routeName,
          arguments: ImagePreviewPage(
            imageFilePath: image.path,
            receiverId: receiverId,
            isGroupChat: isGroupChat,
          )
      );
    }
  }
}

class AttachmentCardItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onPress;

  const AttachmentCardItem({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: IconButton(
              icon: Icon(icon),
              splashRadius: 28,
              onPressed: onPress,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(name)
        ],
      ),
    );
  }
}

