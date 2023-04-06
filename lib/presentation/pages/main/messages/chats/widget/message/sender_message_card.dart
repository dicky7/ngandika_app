import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../../../utils/styles/style.dart';

class SenderMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const SenderMessageCard({Key? key, required this.message, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: context.width(0.8), minWidth: 120, maxHeight: 400),
        child: Card(
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.zero),
          ),
          color: kPrimaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 30, top: 5, bottom: 17),
                child: Text(
                  message,
                  style: context.bodyLarge?.copyWith(color: kBlackColor),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Text(
                  date,
                  style: context.bodySmall?.copyWith(color: Colors.black12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
