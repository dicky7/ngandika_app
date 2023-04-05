import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class TagChatTime extends StatelessWidget {
  final DateTime dateTime;

  const TagChatTime({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12
        ),
        child: Text(
          dateTime.getChatDayTime,
          style: context.titleSmall?.copyWith(color: kPrimaryColor),
        ),
      ),
    );
  }
}
