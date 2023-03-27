import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/chats/chat_page.dart';
import 'package:ngandika_app/presentation/pages/main/contacts_chat/widget/contact_app_bar.dart';
import 'package:ngandika_app/presentation/pages/main/contacts_chat/widget/contact_profile_profile_fialog.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../utils/helpers.dart';
import '../../../../utils/models_helper.dart';
import 'widget/story_card.dart';

class ContactsChatPage extends StatelessWidget {
  const ContactsChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContactAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildStories(),
            buildContactChat()
          ],
        ),
      ),
    );
  }


  Widget buildStories(){
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

  Widget buildContactChat(){
    final Faker faker = Faker();
    final date = Helpers.randomDate();

    return Container(
      margin: const EdgeInsets.only(bottom: 100, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ListView.builder(
        itemCount: chatList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CustomListTile(
            onTap: () {
              Navigator.pushNamed(context, ChatPage.routeName);
            },
            leading: Hero(
              tag: faker.person.name(),
              child: InkWell(
                onTap: () {
                  showContactProfileDialog(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: Helpers.randomPictureUrl(),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            title: faker.person.name(),
            subTitle: faker.food.cuisine(),
            time: date.minute.toString(),
            numOfMessageNotSeen: 2,
          );
        },
      ),
    );
  }

}
