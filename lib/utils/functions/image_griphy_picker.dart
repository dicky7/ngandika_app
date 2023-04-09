import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../styles/style.dart';

// The pickGif function appears to be a Flutter function that retrieves a GIF using the Giphy API
Future<GiphyGif?> pickGif(BuildContext context) async {
  //Define a GiphyGif? variable gif to store the retrieved GIF.
  GiphyGif? gif;
  try {
    //fetch a GIF using the GiphyGet.getGif() function, passing in the context and an API key as arguments.
    //If the GIF is successfully fetched, it is stored in the gif variable.
    gif = await GiphyGet.getGif(
      context: context,
      apiKey: 'U9IfXl9GfrGS2CTkAmSLd2HXqVBf3Xg5',
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
  //Finally, the function returns the retrieved gif variable,
  return gif;
}

//This function pickImageFromGallery uses the ImagePicker package to allow the user to pick an image from their device's gallery.
Future<File?> pickImageFromGallery(BuildContext context) async {
  //The function first initializes a null File object named image.
  File? image;
  try {
    // then uses the ImagePicker package to pick an image from the gallery using the pickImage method. If the user successfully picks an image,
    // the function sets the image variable to a File object with the path to the selected image.
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    //If an error occurs during the image picking process, the function catches the error and displays a snack bar with the error message.
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return image;
}

//This function pickImageFromCamera uses the ImagePicker package to allow the user to pick an image from their device's gallery.
Future<File?> pickImageFromCamera(BuildContext context) async {
  //The function first initializes a null File object named image.
  File? image;
  try {
    // then uses the ImagePicker package to pick an image from the camera using the pickImage method. If the user successfully picks an image,
    // the function sets the image variable to a File object with the path to the selected image.
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    //If an error occurs during the image picking process, the function catches the error and displays a snack bar with the error message.
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return image;
}

//Note that the returned CroppedFile object can be null if the user cancels the cropping process or if an error occurs during cropping.
// To handle these cases, the calling code should check whether the object is null before using it.
Future<CroppedFile?> cropImage(String filePath) async {
  //The ImageCropper package allows the user to customize various aspects of the cropping process, such as the aspect ratio presets,
  // compression settings, maximum width and height, and crop style.
  return ImageCropper().cropImage(
      sourcePath: filePath,
      //On Android, the function uses a specific set of aspect ratio presets, while on other platforms it uses a different set.
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      compressQuality: 100,
      maxWidth: 400,
      maxHeight: 400,
      compressFormat: ImageCompressFormat.jpg,
      cropStyle: CropStyle.rectangle,
      uiSettings: [
        //The Android UI settings are also customized with specific values for the toolbar title, toolbar color, and initial aspect ratio.
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: kBlue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          hideBottomControls: true,
          lockAspectRatio: false,
        ),
      ]);
}
