import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

class TimeSentMessageWidget extends StatelessWidget {
  const TimeSentMessageWidget({
    super.key,
    required this.messageData,
  });

  final MessageModel messageData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(messageData.timeSent.getTimeSentAmPmMode,
              style: context.bodySmall!.copyWith(color: Colors.white60)),
          const SizedBox(width: 5),
          const Icon(
            Icons.done_all,
            size: 20,
            color: Colors.white60,
          ),
        ],
      ),
    );
  }
}
