import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/bottom_field_preview.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/widget/preview/preview_app_bar_icon.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../../../data/models/user_model.dart';
import '../../../../../../utils/enums/message_type.dart';
import '../../../../../../utils/functions/app_dialogs.dart';
import '../../../../../../utils/functions/image_griphy_picker.dart';
import '../../../../../bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import '../../../../../bloc/status/status_cubit.dart';

class ImagePreviewPage extends StatefulWidget {
  static const routeName = "image-preview";

  String imageFilePath;
  final String? receiverId;
  final UserModel? userData;

  ImagePreviewPage(
      {Key? key, required this.imageFilePath, this.receiverId, this.userData})
      : super(key: key);

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final TextEditingController captionController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
                captionController: captionController,
                onSendButtonTaped: () {
                  if (widget.receiverId != null) {
                    context.read<ChatCubit>().sendFileMessage(
                        file: File(widget.imageFilePath),
                        receiverId: widget.receiverId!,
                        messageType: MessageType.image
                    );
                    //to back to chat screen
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  } else {
                    List<String> contactUid = context.read<GetContactsOnAppCubit>().contactUid; // to fetch user id on app for upload status

                    context.read<StatusCubit>().addStatus(
                        username: widget.userData!.name,
                        profilePicture: widget.userData!.profilePicture,
                        phoneNumber: widget.userData!.phoneNumber,
                        statusImage: File(widget.imageFilePath),
                        uidOnAppContact: contactUid,
                        caption: captionController.text.trim()
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
