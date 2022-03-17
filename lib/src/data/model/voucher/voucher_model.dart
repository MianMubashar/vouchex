class VoucherModel{
  final String backgroundImage;
  final String circleImage;
  final String title;
  final String number;
  final String? subtitle;

  VoucherModel({
    required this.backgroundImage,
    required this.circleImage,
    required this.title,
    required this.number,
    this.subtitle
});
}

List<VoucherModel> voucherList = <VoucherModel>[
  VoucherModel(backgroundImage: "assets/images/v_bg_1.png", circleImage: "assets/images/voucher_img_1.png", title: "Up to 10% off on per\nProduct", number: "#557055"),
  VoucherModel(backgroundImage: "assets/images/v_bg_1.png", circleImage: "assets/images/voucher_img_1.png", title: "Up to 10% off on per\nProduct", number: "#557055"),
  VoucherModel(backgroundImage: "assets/images/v_bg_2.png", circleImage: "assets/images/voucher_img_2.png", title: "Buy 1 Get 1", number: "#557055", subtitle: "2 TenderCrisp + 2 Drinks in RS:550 + Tax on Free\nIteam"),
  VoucherModel(backgroundImage: "assets/images/v_bg_2.png", circleImage: "assets/images/voucher_img_2.png", title: "Buy 1 Get 1", number: "#557055", subtitle: "2 TenderCrisp + 2 Drinks in RS:550 + Tax on Free\nIteam")
];

List<VoucherModel> myVoucherList = <VoucherModel>[
  VoucherModel(backgroundImage: "assets/images/v_bg_1.png", circleImage: "assets/images/voucher_img_1.png", title: "Upto 10% off on per\nProduct", number: "#557055"),
];

List<VoucherModel> swappedVoucherList = <VoucherModel>[
  VoucherModel(backgroundImage: "assets/images/v_bg_2.png", circleImage: "assets/images/voucher_img_2.png", title: "Buy 1 Get 1", number: "#557055", subtitle: "2 TenderCrisp + 2 Drinks in RS:550 + Tax on Free\nIteam"),
];

List<VoucherModel> vouchexList = <VoucherModel>[
  VoucherModel(backgroundImage: "assets/images/vx_bg.png", circleImage: "assets/images/vx_img.png", title: "Up to 10% off on per\nMockup Designs", number: "50"),
  VoucherModel(backgroundImage: "assets/images/vx_bg.png", circleImage: "assets/images/vx_img.png", title: "Up to 10% off on per\nMockup Designs", number: "15"),
];