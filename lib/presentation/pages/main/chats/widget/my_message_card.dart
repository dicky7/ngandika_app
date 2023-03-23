import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  const MyMessageCard({Key? key, required this.message, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.width(0.8),
        ),
        child: Card(
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.zero
            ),
          ),
          color: kBlueLight,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 30, top: 5, bottom: 25),
                child: Text(
                  message,
                  style: context.bodyLarge?.copyWith(color: kPrimaryColor),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style: context.bodySmall?.copyWith(color: Colors.white60),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.done_all,
                      color: Colors.white60,
                    )
                  ],
                ),
              )
            ],
          ),


        ),
      ),
    );
  }
}
