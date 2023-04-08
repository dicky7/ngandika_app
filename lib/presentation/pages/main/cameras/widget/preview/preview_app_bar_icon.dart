import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class PreviewAppBarIcon extends StatelessWidget {
  final VoidCallback? onPressCropped;
  final bool isVideoPreview;

  const PreviewAppBarIcon({Key? key, this.onPressCropped, required this.isVideoPreview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.clear),
          color: kPrimaryColor,
          iconSize: 30,
        ),
        const Spacer(),
        isVideoPreview
            ? const SizedBox()
            : IconButton(
                onPressed: onPressCropped,
                icon: Icon(Icons.crop, color: kPrimaryColor),
                iconSize: 27,
              ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.emoji_emotions),
          color: kPrimaryColor,
          iconSize: 27,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.title),
          color: kPrimaryColor,
          iconSize: 27,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          color: kPrimaryColor,
          iconSize: 27,
        )
      ],
    );
  }
}
