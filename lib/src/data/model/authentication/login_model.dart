
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.token,
    required this.message,
    required this.user,
  });

  bool status;
  String token;
  String message;
  User user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.phoneNo,
    required this.deviceToken,
    this.emailVerifiedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    this.roleId,
    required this.countryCode,
    this.businessTypeId,
    this.businessId,
    this.profilePhotoUrl,
  });

  int id;
  String? name;
  String? email;
  String? phoneNo;
  String deviceToken;
  String? emailVerifiedAt;
  String? currentTeamId;
  String? profilePhotoPath;
  DateTime createdAt;
  DateTime updatedAt;
  String? roleId;
  String countryCode;
  String? businessTypeId;
  int? businessId;
  String? profilePhotoUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    deviceToken: json["device_token"],
    emailVerifiedAt: json["email_verified_at"],
    currentTeamId: json["current_team_id"],
    profilePhotoPath: json["profile_photo_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    roleId: json["role_id"],
    countryCode: json["country_code"],
    businessTypeId: json["business_type_id"],
    businessId: json["business_id"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_no": phoneNo,
    "device_token": deviceToken,
    "email_verified_at": emailVerifiedAt,
    "current_team_id": currentTeamId,
    "profile_photo_path": profilePhotoPath,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "role_id": roleId,
    "country_code": countryCode,
    "business_type_id": businessTypeId,
    "business_id": businessId,
    "profile_photo_url": profilePhotoUrl,
  };
}
