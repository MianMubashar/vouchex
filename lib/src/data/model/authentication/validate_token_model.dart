import 'dart:convert';

ValidateTokenModel validateTokenModelFromJson(String str) => ValidateTokenModel.fromJson(json.decode(str));

String validateTokenModelToJson(ValidateTokenModel data) => json.encode(data.toJson());

class ValidateTokenModel {
  ValidateTokenModel({
    required this.status,
    required this.user,
  });

  bool status;
  ValidateUser user;

  factory ValidateTokenModel.fromJson(Map<String, dynamic> json) => ValidateTokenModel(
    status: json["status"],
    user: ValidateUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user.toJson(),
  };
}

class ValidateUser {
  ValidateUser({
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
  ValidateBusiness? business;

  factory ValidateUser.fromJson(Map<String, dynamic> json) => ValidateUser(
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
    business: json['business'] != null ? ValidateBusiness.fromJson(json['business']) : null,
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

class ValidateBusiness {
  ValidateBusiness({
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
  ValidateBusinessType? businessType;

  factory ValidateBusiness.fromJson(Map<String, dynamic> json) => ValidateBusiness(
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
    countryCode : json["country_code"],
    businessType: ValidateBusinessType.fromJson(json["business_type"]),
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
    "country_code" : countryCode,
    "business_type": businessType!.toJson(),
  };
}

class ValidateBusinessType {
  ValidateBusinessType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  factory ValidateBusinessType.fromJson(Map<String, dynamic> json) => ValidateBusinessType(
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
