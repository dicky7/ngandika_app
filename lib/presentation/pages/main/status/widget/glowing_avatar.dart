import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class GlowingAvatar extends StatelessWidget {
  final String imageUrl;
  final double? radius;

  const GlowingAvatar({
    Key? key,
    required this.imageUrl,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = radius != null ? radius! * 2 : null;
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kBlue.withOpacity(0.3),
          width: 4.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 1.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: height,
          width: height,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.asset("assets/user_default.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
