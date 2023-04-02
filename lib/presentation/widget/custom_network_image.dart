import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? radius;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = radius != null ? radius! * 2 : null;
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset("assets/user_default.png"),
        fit: BoxFit.cover,
      ),
    );
  }
}
