class OnBoardingContent {
  String image;
  String title;
  String description;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.description});
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
      title: 'Start Trading',
      image: 'assets/images/onboarding_img_1.png',
      description: "Create your own voucher and\ntrade it with others in the marketplace"
  ),
  OnBoardingContent(
      title: '',
      image: 'assets/images/onboarding_img_2.png',
      description: ""
  ),
];