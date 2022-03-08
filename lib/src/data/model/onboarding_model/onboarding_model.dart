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
      title: 'Get Discount',
      image: 'assets/images/onboarding_img_1.png',
      description: "Faster,cheaper global money transfers.plus\nyour first few transfer are fee-free"
  ),
  OnBoardingContent(
      title: 'Exchange vouchers with others',
      image: 'assets/images/onboarding_img_2.png',
      description: "Faster,cheaper global money transfers.plus\nyour first few transfer are fee-free"
  ),
];