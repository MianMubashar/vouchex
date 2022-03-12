class NotificationModel {
  final String title;
  final String subtitle;
  final String imageUrl;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl
});
}

List<NotificationModel> notificationsList = <NotificationModel>[
  NotificationModel(title: "North9 accept your exchange request", subtitle: "1d ago", imageUrl: "assets/images/profile_img_1.png"),
  NotificationModel(title: "Adidas accept your exchange request", subtitle: "3d ago", imageUrl: "assets/images/adidas_img.png")
];