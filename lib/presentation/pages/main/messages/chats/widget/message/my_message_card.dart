import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/message_content_type.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class MyMessageCard extends StatelessWidget {
  final MessageModel message;

  const MyMessageCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.width(0.8),
          minWidth: 120,
          maxHeight: 400,
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
          child: MessageContentType(messageData: message)
        ),
      ),
    );
  }
}
