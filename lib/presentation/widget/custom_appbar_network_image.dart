import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAppbarNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CustomAppbarNetworkImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Image.asset("assets/user_default.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
