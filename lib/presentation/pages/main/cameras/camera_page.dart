import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/appbar/camera_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/image_preview_page.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/video_preview_page.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../utils/functions/image_picker.dart';

late List<CameraDescription> cameras;

class CameraPage extends StatefulWidget {
  static const routeName = "camera";

  // to define where camera is open up
  final bool isCameraChat;
  final String receiverId;
  const CameraPage({Key? key, required this.receiverId, required this.isCameraChat}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // _cameraValue is to get camera isInitialized or not
  late Future<void> _cameraValue;
  late CameraController _cameraController;
  bool isFlashOn = false;
  bool isCameraFront = true;
  bool isRecording = false;

  // initState  is responsible for initializing the camera controller with the desired camera and resolution settings, and captures
  // the initialization status in a future (_cameraValue) for further use in the widget's state.
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CameraAppBar(
        isFlashOn: isFlashOn,
        onFlashPressed: onFlashPressed,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                buildPreviewImage(),
                isRecording ? buildTimerRecording() : const SizedBox(),
                buildCameraButton()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: Text(
              'Hold for video, tap for photo',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }


  // Preview image
  Widget buildPreviewImage() {
    return FutureBuilder(
      future: _cameraValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading();
        }else{
          return SizedBox(
            width: double.infinity,
            child: CameraPreview(_cameraController),
          );
        }
      },
    );
  }



  Widget buildTimerRecording() {
    return Align(
      alignment: Alignment.topCenter,
      child:TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 60.0),
        duration: const Duration(seconds: 60),
        onEnd: () {},
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: kRedColor
            ),
            child: Text(
              "00:${value.toInt()}",
              style: context.titleMedium?.copyWith(color: kPrimaryColor),
            ),
          );
        },
      ),
    );
  }

  // bottom icon take photo and pick image gallery
  Widget buildCameraButton() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => selectImageFromGallery(context),
            icon: const Icon(Icons.image),
            color: kPrimaryColor,
            iconSize: 34,
            splashRadius: 20,
          ),
          GestureDetector(
            onTap: () => onTapTakePhoto(),
            onLongPress: () => onRecordVideo(),
            onLongPressUp: () => onStopSendVideoRecording(),
            child: cameraIcon(),
          ),
          IconButton(
            onPressed: () => flipCameraFront(),
            icon: const Icon(Icons.flip_camera_android),
            color: kPrimaryColor,
            iconSize: 30,
          )

        ],
      ),
    );
  }

  //The onFlashPressed method is a callback function that is called when the flash button is pressed in the camera app. It is responsible for toggling
  // the flash mode of the camera between "torch" mode (i.e., the flash stays on continuously) and "off" mode (i.e., the flash is turned off).
  void onFlashPressed(){
    //Note that setState is used to update the widget's state so that the changes are reflected in the UI.
    setState(() {
      isFlashOn = !isFlashOn;
    });
    isFlashOn
        ? _cameraController.setFlashMode(FlashMode.torch)
        : _cameraController.setFlashMode(FlashMode.off);
  }

  // This  function that selects an image from the device's gallery,
  void selectImageFromGallery(BuildContext context) async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      //to avoid warning Don't use 'BuildContext's across async gaps.
      if(!mounted) return;
      Navigator.pushNamed(
          context,
          ImagePreviewPage.routeName,
          arguments: ImagePreviewPage(
              imageFilePath: image.path,
              isCameraChat: widget.isCameraChat,
              receiverId: widget.receiverId
          )
      );
    }
  }

  //This function is responsible for flipping between the front and back camera of the device when called.
  void flipCameraFront() {
    //it toggles the value of the isCameraFront boolean variable, which determines whether the front or back camera is currently active
    setState(() {
      isCameraFront = !isCameraFront;
    });
    //Next, it calculates the camera position to be used based on the updated isCameraFront value. If isCameraFront is true, it sets cameraPos to 0,
    // indicating that the front camera should be used; otherwise, it sets cameraPos to 1, indicating that the back camera should be used.
    int cameraPos = isCameraFront ? 0 : 1;
    //It then creates a new instance of CameraController with the updated camera position and a ResolutionPreset.high resolution preset.
    // The _cameraController variable, which is of type CameraController, is updated with this new instance.
    _cameraController = CameraController(cameras[cameraPos], ResolutionPreset.high);
    //Finally, it calls _cameraController.initialize() to initialize the camera with the updated camera position and resolution preset, and assigns
    // the returned Future to _cameraValue. This future represents the asynchronous process of initializing the camera, and it can be used
    // to determine when the camera is fully initialized before performing further operations on it.
    _cameraValue = _cameraController.initialize();
  }


  //thia method handles the logic for capturing a photo using the camera when the user taps on the take photo button in the UI.
  void onTapTakePhoto() async{
    //It first checks if the camera is currently recording a video (isRecording flag is false). If the camera is recording, it skips the rest of the method and does nothing.
    if (!isRecording) {
      // it proceeds to capture a photo using the _cameraController.takePicture() method, which is an asynchronous operation that returns an XFile representing the captured image file.
      XFile file = await _cameraController.takePicture();
      //to avoid warning Don't use 'BuildContext's across async gaps.
      if(!mounted) return;
      Navigator.pushNamed(
          context,
          ImagePreviewPage.routeName,
          arguments: ImagePreviewPage(
              imageFilePath: file.path,
              isCameraChat: widget.isCameraChat,
              receiverId: widget.receiverId)
      );
    }
  }

  //when user long press button it'll start recording a video and set isRecording true
  void onRecordVideo() async{
    await _cameraController.startVideoRecording();
    setState(() {
      isRecording = true;
    });
  }

  //when user long press up button it'll stop record a video, set isRecording to false and automatically go to VideoPreviewPage to show the video preview
  void onStopSendVideoRecording() async{
    XFile videoPath = await _cameraController.stopVideoRecording();
    setState(() {
      isRecording = false;
    });
    if(!mounted) return;
    Navigator.pushNamed(context, VideoPreviewPage.routeName, arguments: VideoPreviewPage(
        isCameraChat: widget.isCameraChat,
        receiverId: widget.receiverId,
        videoFilePath: videoPath.path));

  }

  Widget cameraIcon() {
    return isRecording
        ? const Icon(Icons.radio_button_on, color: Colors.red, size: 80,)
        : const Icon(Icons.panorama_fish_eye, size: 80, color: Colors.white);
  }
}
