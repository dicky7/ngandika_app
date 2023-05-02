import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/presentation/pages/main/messages/groups/widget/input_group_name.dart';
import 'package:ngandika_app/presentation/pages/main/messages/groups/widget/select_contact_group.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../bloc/message/message_groups/message_groups_cubit.dart';
import '../../../onboarding/login/pick_profile_picture_bottomsheet.dart';

class CreateGroupPage extends StatefulWidget {
  static const routeName = 'create-group';

  final  Map<String, dynamic> contactOnApp;
  const CreateGroupPage({Key? key, required this.contactOnApp}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController groupNameController = TextEditingController();

  // variable to store converted CroppedFile to file
  File? _selectedImage;

  // Define a method to show the modal bottom sheet and select an image
  Future<void> _updateProfilePicture() async {
    CroppedFile? croppedFile = await showPickProfilePictureBottomSheet(context);
    if (croppedFile != null) {
      setState(() {
        //convert the selected CroppedFile object to a File
        _selectedImage = File(croppedFile.path);
      });
    }
  }

  void createGroup(){
    final String groupName =  groupNameController.text.trim();
    if (groupName.isNotEmpty && _selectedImage != null) {
      final List<String> selectedUidContact = context.read<MessageGroupsCubit>().selectedContactUId;
      context.read<MessageGroupsCubit>().createGroup(groupName, _selectedImage!, selectedUidContact);

      Navigator.pushNamedAndRemoveUntil(context, MainPage.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 2,
        leading: BackButton(color: kGreyColor),
        title: Text(
          "Create Group",
          style: context.titleLarge?.copyWith(color: kGreyColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildProfilePicture(context),
            InputGroupName(nameController: groupNameController),
            buildText(context),
            SelectContactGroup(contactOnApp: widget.contactOnApp)
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlue,
        child: Icon(Icons.done, color: kPrimaryColor),
        onPressed: createGroup
      ),
    );
  }

  // Define a method to display the selected image in a CircleAvatar
  Widget _buildAvatar() {
    if (_selectedImage != null) {
      return CircleAvatar(
        backgroundImage: FileImage(File(_selectedImage!.path)),
        radius: 80,
      );
    } else {
      return CircleAvatar(
        radius: 80,
        backgroundColor: kGreyColor,
        child: Icon(
          Icons.person,
          color: kPrimaryColor,
          size: 85,
        ),
      );
    }
  }

  Widget buildProfilePicture(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      alignment: Alignment.center,
      child: Stack(
        children: [
          _buildAvatar(),
          Positioned(
            bottom: 10,
            right: 1,
            child: CircleAvatar(
              backgroundColor: kBlueDark,
              radius: 20,
              child: IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: kPrimaryColor,
                  size: 20,
                ),
                onPressed: () {
                  _updateProfilePicture();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: Text(
        "Select Contacts",
        style: TextStyle(color: kBlue, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
