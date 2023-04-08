import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/time_sent_message_widget.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../../../utils/styles/style.dart';

class TextMessageWidget extends StatelessWidget {
  final MessageModel messageData;

  const TextMessageWidget({Key? key, required this.messageData})
      : super(key: key);

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
        TimeSentMessageWidget(messageData: messageData)
      ],
    );
  }
}
