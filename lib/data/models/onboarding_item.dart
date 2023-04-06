class OnBoardingData {
  final String image, tittle, description;

  OnBoardingData(
      {required this.image, required this.tittle, required this.description});
}

final List<OnBoardingData> onBoardItem = [
  OnBoardingData(
      image: "assets/onBoarding_1.png",
      tittle: "Put Yourself Out There",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt. "),
  OnBoardingData(
      image: "assets/onBoarding_2.png",
      tittle: "Customise Your Profile",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt. "),
  OnBoardingData(
      image: "assets/onBoarding_3.png",
      tittle: "Connect With Your Friends",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt. "),
];
