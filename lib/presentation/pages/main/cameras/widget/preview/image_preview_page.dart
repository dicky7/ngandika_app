import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/bottom_field_preview.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/preview_app_bar_icon.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../../../utils/enums/message_type.dart';
import '../../../../../../utils/functions/image_picker.dart';

class ImagePreviewPage extends StatefulWidget {
  static const routeName = "image-preview";

  // to define where camera is open up
  final bool isCameraChat;
  String imageFilePath;
  final String receiverId;

  ImagePreviewPage({Key? key, required this.imageFilePath, required this.receiverId, required this.isCameraChat}) : super(key: key);

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        body: Stack(
          children: [
            Image.file(
              File(widget.imageFilePath),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
            PreviewAppBarIcon(
              isVideoPreview: false,
              onPressCropped: () {
                cropImage(widget.imageFilePath).then((value) {
                  widget.imageFilePath = value!.path;
                  //calling set state to rebuild
                  setState(() {

                  });
                });
              },
            ),
            Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: BottomFieldPreview(
                onSendButtonTaped: () {
                  if (widget.isCameraChat) {
                    context.read<ChatCubit>().sendFileMessage(
                        file: File(widget.imageFilePath),
                        receiverId: widget.receiverId,
                        messageType: MessageType.image
                    );
                    //to back to chat screen
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
