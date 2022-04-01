// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.status,
    required this.token,
    required this.message,
    required this.user,
  });

  bool status;
  String token;
  String message;
  User user;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json["status"],
    token: json["token"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    this.name,
    this.email,
    required this.phoneNo,
    required this.deviceToken,
    this.profilePhotoPath,
    required this.createdAt,
    this.roleId,
    required this.countryCode,
    this.businessId,
    required this.profilePhotoUrl,
  });

  int id;
  String? name;
  String? email;
  String phoneNo;
  String deviceToken;
  String? profilePhotoPath;
  DateTime createdAt;
  int? roleId;
  String countryCode;
  int? businessId;
  String profilePhotoUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_no": phoneNo,
    "device_token": deviceToken,
    "profile_photo_path": profilePhotoPath,
    "created_at": createdAt.toIso8601String(),
    "role_id": roleId,
    "country_code": countryCode,
    "business_id": businessId,
    "profile_photo_url": profilePhotoUrl,
  };
}
