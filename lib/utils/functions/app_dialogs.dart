import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../styles/style.dart';

class AppDialogs {
  static Future<void> submitPhoneDialog({
    required BuildContext context,
    required String phoneNumber,
    required VoidCallback okPressed,
  }) {
    return showMyDialog(
      context: context,
      actionSpacer: true,
      borderRadius: 3,
      contentPadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("You entered the phone number:"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              phoneNumber,
              style: context.titleLarge?.copyWith(color: kBlue),
            ),
          ),
          const Text("Is this OK, or would you like to edit the number?"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Edit",
            style: TextStyle(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: okPressed,
          child: Text(
            "Ok",
            style: TextStyle(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> showCustomDialog(
      {required BuildContext context,
      required IconData icons,
      required String title,
      required String content,
      required VoidCallback onPressed}) async {
    return showMyDialog(
      context: context,
      contentPadding: const EdgeInsets.all(15),
      borderRadius: 15,
      barrierDismissible: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icons,
            color: kBlackColor,
            size: 100,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: kGreyColor),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: context.width(0.35),
            height: 45,
            decoration: BoxDecoration(
                color: kBlue, borderRadius: BorderRadius.circular(10)),
            child: TextButton(
                onPressed: onPressed,
                child: Text(
                  "Ok",
                  style: TextStyle(color: kPrimaryColor),
                )),
          )
        ],
      ),
    );
  }
}

Future<void> showMyDialog(
    {required BuildContext context,
    bool barrierDismissible = false,
    double borderRadius = 0,
    EdgeInsetsGeometry? contentPadding,
    required Widget content,
    List<Widget>? actions,
    bool actionSpacer = false,
    EdgeInsetsGeometry? actionsPadding}) async {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    // if condition false, user must tap button!
    builder: (context) {
      return AlertDialog(
        contentPadding: contentPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        content: content,
        actionsPadding: actionsPadding,
        actions: actions,
        actionsAlignment: actionSpacer
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
      );
    },
  );
}
