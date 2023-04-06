import 'package:flutter/material.dart';

import '../../utils/styles/style.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subTitle;
  final String? time;
  final Widget? titleButton;
  final int numOfMessageNotSeen;
  final VoidCallback onTap;
  final VoidCallback? onLeadingTap;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.time,
    this.numOfMessageNotSeen = 0,
    this.titleButton,
    required this.onTap,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading ??
          InkWell(
            onTap: onLeadingTap,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.asset("assets/user_default.png"),
            ),
          ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              //style: context.headlineSmall,
              style: Theme.of(context).textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (time != null)
            Text(
              time!,
              style: numOfMessageNotSeen > 0
                  ? Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: kBlueDark)
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          if (titleButton != null)
            SizedBox(
              height: 40,
              child: titleButton!,
            ),
        ],
      ),
      subtitle: subTitle != null
          ? Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Row(
                children: [
                  //Icon(Icons.done_all,size: 20,),
                  Expanded(
                    child: Text(
                      subTitle!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: kGreyColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (numOfMessageNotSeen > 0)
                    CircleAvatar(
                      minRadius: 12,
                      backgroundColor: kBlueLight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          numOfMessageNotSeen.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: kPrimaryColor),
                        ),
                      ),
                    ),
                ],
              ),
            )
          : null,
    );
  }
}
