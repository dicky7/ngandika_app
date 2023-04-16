import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';

class TimeSentMessageWidget extends StatelessWidget {
  final MessageModel messageData;
  final Color colors;
  final bool isSender;

  const TimeSentMessageWidget({
    super.key,
    required this.messageData,
    required this.colors, required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(messageData.timeSent.getTimeSentAmPmMode, style: context.bodySmall!.copyWith(color: colors)),
          const SizedBox(width: 5),
          if(isSender)
            Icon(
              Icons.done_all,
              size: 20,
              color: colors,
            ),
        ],
      ),
    );
  }
}
