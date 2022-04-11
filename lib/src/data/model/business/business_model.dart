/*
import 'dart:convert';
GetBusinessesModel getBusinessesModelFromJson(String str) => GetBusinessesModel.fromJson(json.decode(str));

String getBusinessesModelToJson(GetBusinessesModel data) => json.encode(data.toJson());

class GetBusinessesModel {
  GetBusinessesModel({
    this.status,
    this.businesses,
  });

  bool? status;
  Businesses? businesses;

  factory GetBusinessesModel.fromJson(Map<String, dynamic> json) => GetBusinessesModel(
    status: json["status"],
    businesses: Businesses.fromJson(json["businesses"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "businesses": businesses!.toJson(),
  };
}

class Businesses {
  Businesses({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Businesses.fromJson(Map<String, dynamic> json) => Businesses(
    currentPage: json["current_page"],
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.coverPhotoPath,
    required this.profilePhotoPath,
    required this.businessTypeId,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.phoneNo,
  });

  int id;
  String name;
  String description;
  String coverPhotoPath;
  String profilePhotoPath;
  int businessTypeId;
  DateTime createdAt;
  DateTime updatedAt;
  String email;
  String phoneNo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "cover_photo_path": coverPhotoPath,
    "profile_photo_path": profilePhotoPath,
    "business_type_id": businessTypeId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "email": email,
    "phone_no": phoneNo,
  };
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

*/

// To parse this JSON data, do
//
//     final getBusinessesModel = getBusinessesModelFromJson(jsonString);

import 'dart:convert';

GetBusinessesModel getBusinessesModelFromJson(String str) => GetBusinessesModel.fromJson(json.decode(str));

String getBusinessesModelToJson(GetBusinessesModel data) => json.encode(data.toJson());

class GetBusinessesModel {
  GetBusinessesModel({
    this.status,
    this.businesses,
  });

  bool? status;
  Businesses? businesses;

  factory GetBusinessesModel.fromJson(Map<String, dynamic> json) => GetBusinessesModel(
    status: json["status"],
    businesses: Businesses.fromJson(json["businesses"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "businesses": businesses!.toJson(),
  };
}

class Businesses {
  Businesses({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Businesses.fromJson(Map<String, dynamic> json) => Businesses(
    currentPage: json["current_page"],
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
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
    this.businessType,
    this.vouchers,
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
  BusinessType? businessType;
  List<Voucher>? vouchers;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    businessType: BusinessType.fromJson(json["business_type"]),
    vouchers: json["vouchers"] != null ? List<Voucher>.from(json["vouchers"].map((x) => Voucher.fromJson(x))) : null,
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
    "business_type": businessType!.toJson(),
    "vouchers": List<dynamic>.from(vouchers!.map((x) => x.toJson())),
  };
}

class BusinessType {
  BusinessType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
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

class Voucher {
  Voucher({
    this.id,
    this.uuId,
    this.name,
    this.code,
    this.isFree,
    this.marketValue,
    this.termsConditions,
    this.isStatic,
    this.expiry,
    this.userId,
    this.isRedeemed,
    this.isSwapped,
    this.isVouchex,
    this.profilePhotoPath,
    this.coverPhotoPath,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.laravelThroughKey,
  });

  int? id;
  String? uuId;
  String? name;
  String? code;
  int? isFree;
  String? marketValue;
  String? termsConditions;
  String? isStatic;
  DateTime? expiry;
  int? userId;
  String? isRedeemed;
  String? isSwapped;
  String? isVouchex;
  String? profilePhotoPath;
  String? coverPhotoPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? laravelThroughKey;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    id: json["id"],
    uuId: json["uu_id"],
    name: json["name"],
    code: json["code"],
    isFree: json["is_free"],
    marketValue: json["market_value"],
    termsConditions: json["terms_conditions"],
    isStatic: json["is_static"],
    expiry: DateTime.parse(json["expiry"]),
    userId: json["user_id"],
    isRedeemed: json["is_redeemed"],
    isSwapped: json["is_swapped"],
    isVouchex: json["is_vouchex"],
    profilePhotoPath: json["profile_photo_path"],
    coverPhotoPath: json["cover_photo_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    laravelThroughKey: json["laravel_through_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uu_id": uuId,
    "name": name,
    "code": code,
    "is_free": isFree,
    "market_value": marketValue,
    "terms_conditions": termsConditions,
    "is_static": isStatic,
    "expiry": "${expiry!.year.toString().padLeft(4, '0')}-${expiry!.month.toString().padLeft(2, '0')}-${expiry!.day.toString().padLeft(2, '0')}",
    "user_id": userId,
    "is_redeemed": isRedeemed,
    "is_swapped": isSwapped,
    "is_vouchex": isVouchex,
    "profile_photo_path": profilePhotoPath,
    "cover_photo_path": coverPhotoPath,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "laravel_through_key": laravelThroughKey,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
