import 'dart:convert';

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

// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);


NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.status,
    this.notifications,
  });

  bool? status;
  List<AppNotification>? notifications;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    status: json["status"],
    notifications: json["notifications"] != null ? List<AppNotification>.from(json["notifications"].map((x) => AppNotification.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "notifications": List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class AppNotification {
  AppNotification({
    required this.id,
    required this.message,
    required this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int id;
  String message;
  int userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  NotificationUser? user;

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
    id: json["id"],
    message: json["message"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: json["user"] != null ? NotificationUser.fromJson(json["user"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "user_id": userId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "user": user!.toJson(),
  };
}

class NotificationUser {
  NotificationUser({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.deviceToken,
    this.profilePhotoPath,
    this.createdAt,
    this.roleId,
    this.countryCode,
    this.businessId,
    this.profilePhotoUrl,
    this.business,
  });

  int? id;
  String? name;
  String? email;
  String? phoneNo;
  String? deviceToken;
  String? profilePhotoPath;
  DateTime? createdAt;
  int? roleId;
  String? countryCode;
  int? businessId;
  String? profilePhotoUrl;
  NotificationBusiness? business;

  factory NotificationUser.fromJson(Map<String, dynamic> json) => NotificationUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    deviceToken: json["device_token"],
    profilePhotoPath: json["profile_photo_path"],
    createdAt: DateTime.parse(json["created_at"]),
    roleId: json["role_id"],
    countryCode: json["country_code"],
    businessId: json["business_id"],
    profilePhotoUrl: json["profile_photo_url"],
    business: NotificationBusiness.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_no": phoneNo,
    "device_token": deviceToken,
    "profile_photo_path": profilePhotoPath,
    "created_at": createdAt!.toIso8601String(),
    "role_id": roleId,
    "country_code": countryCode,
    "business_id": businessId,
    "profile_photo_url": profilePhotoUrl,
    "business": business!.toJson(),
  };
}

class NotificationBusiness {
  NotificationBusiness({
    this.id,
    this.name,
    this.description,
    this.coverPhotoPath,
    this.profilePhotoPath,
    this.businessTypeId,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.phoneNo,
    this.countryCode,
    this.businessType,
  });

  int? id;
  String? name;
  String? description;
  String? coverPhotoPath;
  String? profilePhotoPath;
  int? businessTypeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;
  String? phoneNo;
  String? countryCode;
  NotificationBusinessType? businessType;

  factory NotificationBusiness.fromJson(Map<String, dynamic> json) => NotificationBusiness(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    coverPhotoPath: json["cover_photo_path"],
    profilePhotoPath: json["profile_photo_path"],
    businessTypeId: json["business_type_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    email: json["email"],
    phoneNo: json["phone_no"],
    countryCode: json["country_code"],
    businessType: NotificationBusinessType.fromJson(json["business_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "cover_photo_path": coverPhotoPath,
    "profile_photo_path": profilePhotoPath,
    "business_type_id": businessTypeId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "email": email,
    "phone_no": phoneNo,
    "country_code": countryCode,
    "business_type": businessType!.toJson(),
  };
}

class NotificationBusinessType {
  NotificationBusinessType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  factory NotificationBusinessType.fromJson(Map<String, dynamic> json) => NotificationBusinessType(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
