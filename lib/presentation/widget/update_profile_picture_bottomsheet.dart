import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/functions/image_griphy_picker.dart';
import 'package:ngandika_app/utils/styles/style.dart';

//The function returns a Future<CroppedFile?>, indicating that the user may or may not select an image to crop. If the user selects an image and crops it,
// the function returns the CroppedFile object representing the cropped image. If the user cancels the selection or cropping process,
// the function returns null.
Future<CroppedFile?> showUpdateProfilePictureBottomSheet(
    BuildContext context) async {
  return showModalBottomSheet<CroppedFile>(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15))),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile photo",
              style: context.titleLarge,
            ),
            Row(
              children: [
                //When the user taps on the "Camera" PickProfileImage widget, it calls the the selectImageFromCamera function is called to retrieve the image.
                // The resulting CroppedFile object is then returned by calling Navigator.of(context).pop(croppedFile) to dismiss the bottom sheet.
                PickProfileImage(
                  title: "Camera",
                  icons: Icons.camera_alt,
                  onTap: () async {
                    CroppedFile? croppedFile =
                        await updateImageFromCamera(context);
                    Navigator.of(context).pop(croppedFile);
                  },
                ),
                const SizedBox(width: 30),

                //When the user taps on the "Gallery" PickProfileImage widget, it calls the the selectImageFromGallery function is called to retrieve the selected image.
                // The resulting CroppedFile object is then returned by calling Navigator.of(context).pop(croppedFile) to dismiss the bottom sheet.
                PickProfileImage(
                  title: "Gallery",
                  icons: Icons.image,
                  onTap: () async {
                    CroppedFile? croppedFile = await updateImageFromGallery(context);
                    Navigator.of(context).pop(croppedFile);
                  },
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

// This  function that selects an image from the device's gallery, crops it to a specific size, and returns a CroppedFile object.
// The function returns a Future that resolves to a CroppedFile object or null if an error occurs.
Future<CroppedFile?> updateImageFromGallery(BuildContext context) async {
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
Future<CroppedFile?> updateImageFromCamera(BuildContext context) async {
  File? image = await pickImageFromCamera(context);
  if (image != null) {
    CroppedFile? croppedFile = await cropImage(image.path);
    if (croppedFile != null) {
      return croppedFile;
    }
  }
  return null;
}

class PickProfileImage extends StatelessWidget {
  final String title;
  final IconData icons;
  final VoidCallback onTap;

  const PickProfileImage(
      {Key? key, required this.icons, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 30, bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12)),
            child: Icon(icons, color: kBlue),
          ),
        ),
        Text(
          title,
          style: context.bodyLarge?.copyWith(color: kBlackColor),
        )
      ],
    );
  }
}
