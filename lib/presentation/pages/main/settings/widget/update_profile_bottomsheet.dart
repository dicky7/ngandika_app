//The function returns a Future<CroppedFile?>, indicating that the user may or may not select an image to crop. If the user selects an image and crops it,
// the function returns the CroppedFile object representing the cropped image. If the user cancels the selection or cropping process,
// the function returns null.
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../utils/functions/image_griphy_picker.dart';
import '../../../onboarding/login/pick_profile_picture_bottomsheet.dart';

Future<void> showUpdateProfilePictureBottomSheet(BuildContext context) async {
  return showModalBottomSheet(
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
                  onTap: ()  {
                    updateImageFromCamera(context);
                  },
                ),
                const SizedBox(width: 30),

                //When the user taps on the "Gallery" PickProfileImage widget, it calls the the selectImageFromGallery function is called to retrieve the selected image.
                // The resulting CroppedFile object is then returned by calling Navigator.of(context).pop(croppedFile) to dismiss the bottom sheet.
                PickProfileImage(
                  title: "Gallery",
                  icons: Icons.image,
                  onTap: () {
                    updateImageFromGallery(context);

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
void updateImageFromGallery(BuildContext context) async {
  File? image = await pickImageFromGallery(context);
  if (image != null) {
    CroppedFile? croppedFile = await cropImage(image.path);
    if (croppedFile != null) {
      context.read<UserCubit>().updateProfilePic(croppedFile.path);
      Navigator.pop(context);
    }
  }
}

// This  function that selects an image from the device's camera, crops it to a specific size, and returns a CroppedFile object.
// The function returns a Future that resolves to a CroppedFile object or null if an error occurs.
void updateImageFromCamera(BuildContext context) async {
  File? image = await pickImageFromCamera(context);
  if (image != null) {
    CroppedFile? croppedFile = await cropImage(image.path);
    if (croppedFile != null) {
      context.read<UserCubit>().updateProfilePic(croppedFile.path);
      Navigator.pop(context);
    }
  }
}