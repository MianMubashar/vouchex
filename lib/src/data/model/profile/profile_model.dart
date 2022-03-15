class ProfileModel {
  final String title;
  final String imageUrl;
  final String route;

  ProfileModel({
    required this.title,
    required this.imageUrl,
    required this.route
});
}

List<ProfileModel> profileItems = <ProfileModel>[
  ProfileModel(title: "Register as Business", imageUrl: "assets/images/business_icon.png", route: "/CreateBusiness"),
  ProfileModel(title: "My Vouchers", imageUrl: "assets/images/voucher_icon.png", route: "/MyVouchers"),
  ProfileModel(title: "VouchEx Vouchers", imageUrl: "assets/images/business_icon.png", route: "/VxVouchers"),
  ProfileModel(title: "Notification", imageUrl: "assets/images/notification_icon.png", route: "/Notification"),
  ProfileModel(title: "History", imageUrl: "assets/images/history_icon.png", route: "/History"),
  ProfileModel(title: "Help and Support", imageUrl: "assets/images/help_icon.png", route: "/HelpSupport"), 
  ProfileModel(title: "About", imageUrl: "assets/images/about_icon.png", route: "/About")
];