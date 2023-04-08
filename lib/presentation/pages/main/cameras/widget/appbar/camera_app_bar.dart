import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class CameraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFlashPressed;
  final bool isFlashOn;

  const CameraAppBar({Key? key, required this.onFlashPressed, required this.isFlashOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.clear) ,
      ),
      actions: [
        IconButton(
          onPressed: onFlashPressed,
          icon: Icon(
             isFlashOn ? Icons.flash_on : Icons.flash_off
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
