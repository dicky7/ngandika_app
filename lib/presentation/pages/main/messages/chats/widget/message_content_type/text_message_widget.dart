import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

import '../../../../../../../utils/styles/style.dart';

class TextMessageWidget extends StatelessWidget {
  final MessageModel messageData;

  const TextMessageWidget({Key? key, required this.messageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            messageData.text,
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
                  messageData.timeSent.getTimeSentAmPmMode,
                  style: context.bodySmall!.copyWith(color: Colors.white60)
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.done_all,
                size: 20,
                color: Colors.white60,
              ),
            ],
          ),
        )
      ],
    );
  }
}
