import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../../../../utils/helpers.dart';
import '../../../../../../../utils/models_helper.dart';
import 'story_card.dart';

class ContactsChatStories extends StatelessWidget {
  const ContactsChatStories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Faker faker = Faker();
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 12, bottom: 8),
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: kGreyColor,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatList.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return StoryCard(
                    name: faker.person.name(),
                    image: Helpers.randomPictureUrl(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
