import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/utils/enums/message_type.dart';

import '../../../../../../../utils/functions/image_picker.dart';
import '../../../../../../../utils/styles/style.dart';

class CustomAttachmentPopUp extends StatelessWidget {
  final String receiverId;

  CustomAttachmentPopUp({Key? key, required this.receiverId}) : super(key: key);

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
                  onPress: () async{
                    File? selectedImage;
                    CroppedFile? croppedFile = await selectImageFromGallery(context);
                    if (croppedFile != null) {
                      //convert the selected CroppedFile object to a File
                      selectedImage = File(croppedFile.path);
                      context.read<ChatCubit>().sendFileMessage(file: selectedImage, receiverId: receiverId, messageType: MessageType.image);
                    }
                    Navigator.of(context).pop();
                  },
                ),
                AttachmentCardItem(
                  name: "Gallery",
                  color: Colors.purpleAccent,
                  icon: Icons.photo,
                  onPress: () async {
                    File? selectedImage;
                    CroppedFile? croppedFile = await selectImageFromGallery(context);
                    if (croppedFile != null) {
                        //convert the selected CroppedFile object to a File
                        selectedImage = File(croppedFile.path);
                        context.read<ChatCubit>().sendFileMessage(file: selectedImage, receiverId: receiverId, messageType: MessageType.image);
                    }
                    Navigator.of(context).pop();
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
}

// This  function that selects an image from the device's gallery, crops it to a specific size, and returns a CroppedFile object.
// The function returns a Future that resolves to a CroppedFile object or null if an error occurs.
Future<CroppedFile?> selectImageFromGallery(BuildContext context) async {
  File? image = await pickImageFromGallery(context);
  if (image != null) {
    CroppedFile? croppedFile = await cropImage(image.path);
    if (croppedFile != null) {
      return croppedFile;
    }
  }
  return null;
}

// This  function that selects an image from the device's camera, crops it to a specific size, and returns a CroppedFile object.
// The function returns a Future that resolves to a CroppedFile object or null if an error occurs.
Future<CroppedFile?> selectImageFromCamera(BuildContext context) async {
  File? image = await pickImageFromCamera(context);
  if (image != null) {
    CroppedFile? croppedFile = await cropImage(image.path);
    if (croppedFile != null) {
      return croppedFile;
    }
  }
  return null;
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

