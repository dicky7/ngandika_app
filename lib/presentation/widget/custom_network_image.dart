import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const CustomNetworkImage({Key? key, required this.imageUrl, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: radius * 2,
        placeholder: (context, url) => Stack(
          children: [
            Image.asset("assets/user_default.png"),
            const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          ],
        ),
        errorWidget: (context, url, error) => Image.asset("assets/user_default.png"),
        fit: BoxFit.cover,
      ),
    );
  }
}
