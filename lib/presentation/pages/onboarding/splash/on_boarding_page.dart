import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/onboarding/login/login_page.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../data/models/onboarding_item.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = "on-boarding";

  OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentIndex = 0;

  bool onLastPage = false;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: onBoardItem.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return onBoardingContent(context,
                  image: onBoardItem[index].image,
                  title: onBoardItem[index].tittle,
                  description: onBoardItem[index].description);
            },
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                _currentIndex = index;
              });
            },
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _pageController.jumpToPage(2),
                  child: const Text("Skip"),
                ),
                buildIndicator(
                    itemCount: onBoardItem.length, currentIndex: _currentIndex),
                onLastPage
                    ? GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, LoginPage.routeName),
                        child: const Text("Done"),
                      )
                    : GestureDetector(
                        child: const Text("Nex"),
                        onTap: () => _pageController.nextPage(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 500)),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget onBoardingContent(BuildContext context,
      {required String image,
      required String title,
      required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 300,
          fit: BoxFit.cover,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: context.headlineMedium?.copyWith(color: kBlackColor)),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIndicator({required int itemCount, required int currentIndex}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, (index) {
          return Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: index == currentIndex ? kBlueLight : kGreyColor),
          );
        }));
  }
}
