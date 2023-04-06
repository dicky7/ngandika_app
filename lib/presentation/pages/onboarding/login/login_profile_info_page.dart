import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/widgets/login_app_bar.dart';
import 'package:ngandika_app/presentation/widget/custom_button.dart';
import 'package:ngandika_app/presentation/widget/update_profile_picture_bottomsheet.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../utils/functions/app_dialogs.dart';
import '../../../../utils/styles/style.dart';
import '../../../bloc/auth/auth_cubit.dart';

class LoginProfileInfoPage extends StatefulWidget {
  static const routeName = "profile-info";

  const LoginProfileInfoPage({Key? key}) : super(key: key);

  @override
  State<LoginProfileInfoPage> createState() => _LoginProfileInfoPageState();
}

class _LoginProfileInfoPageState extends State<LoginProfileInfoPage> {
  final TextEditingController nameController = TextEditingController();

  // variable to store converted CroppedFile to file
  File? _selectedImage;

  // Define a method to show the modal bottom sheet and select an image
  Future<void> _updateProfilePicture() async {
    CroppedFile? croppedFile = await showUpdateProfilePictureBottomSheet(context);
    if (croppedFile != null) {
      setState(() {
        //convert the selected CroppedFile object to a File
        _selectedImage = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(
        title: Text("Profile info", style: TextStyle(color: kBlue)),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, MainPage.routeName, (route) => false);
          } else if (state is AuthError) {
            AppDialogs.showCustomDialog(
                context: context,
                icons: Icons.close,
                title: "Error",
                content: state.message,
                onPressed: () => Navigator.pop(context));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please provide your name and an optional profile photo",
                  style: context.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                buildProfilePicture(context),
                const SizedBox(height: 30),
                buildInputUsername(),
                const Spacer(),
                CustomButton(
                  text: "Next",
                  color: kBlueLight,
                  width: context.width(0.65),
                  onPress: () {
                    if (nameController.text.isNotEmpty) {
                      context.read<AuthCubit>().saveUserDataToFirebase(
                          username: nameController.text,
                          profilePicture: _selectedImage);
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
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
    return Stack(
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
    );
  }

  Widget buildInputUsername() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorHeight: 30,
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Type your name here",
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
