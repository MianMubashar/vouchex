class BusinessModel{
  final String backgroundImage;
  final String circleImage;
  final String title;
  final String subtitle;
  final String itemImage;

  BusinessModel({
    required this.backgroundImage,
    required this.circleImage,
    required this.title,
    required this.subtitle,
    required this.itemImage
  });
}

List<BusinessModel> businessList = <BusinessModel>[
  BusinessModel(backgroundImage: "assets/images/v_bg_1.png", circleImage: "assets/images/voucher_img_1.png", title: "Adidas",
      subtitle: "It is the largest sportswear manufacturer in\nEurope, and the second largest in the world.", itemImage: "assets/images/item_img_1.png"),
  BusinessModel(backgroundImage: "assets/images/v_bg_2.png", circleImage: "assets/images/voucher_img_2.png", title: "KFC",
      subtitle: "KFC is an American fast food restaurant headquartered\nin Louisville, Kentucky that specializes in fried chicken.", itemImage: "assets/images/item_img_2.png"),
];
