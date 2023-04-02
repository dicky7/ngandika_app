import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/widget/custom_network_image.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class StoryCard extends StatelessWidget {
  final String image;
  final String name;
  const StoryCard({Key? key, required this.image, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomNetworkImage(
            imageUrl: image,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: kBlackColor,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
