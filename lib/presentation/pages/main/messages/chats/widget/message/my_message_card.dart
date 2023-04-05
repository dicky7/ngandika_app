import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final DateTime timeSent;

  const MyMessageCard({Key? key, required this.message, required this.timeSent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.width(0.8),
          maxHeight: 400,
        ),
        child: Card(
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.zero),
          ),
          color: kBlueLight,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: context.bodyLarge?.copyWith(color: kPrimaryColor),
                  overflow: TextOverflow.visible,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      timeSent.getTimeSentAmPmMode,
                      style: context.bodySmall!.copyWith(color: Colors.white60)
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.done_all,
                      size: 20,
                      color: Colors.white60,
                    ),
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
