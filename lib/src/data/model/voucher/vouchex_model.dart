

import 'dart:convert';

VouchexModel vouchexModelFromJson(String str) => VouchexModel.fromJson(json.decode(str));

String vouchexModelToJson(VouchexModel data) => json.encode(data.toJson());

class VouchexModel {
  VouchexModel({
    required this.status,
    required this.vouchexVouchers,
  });

  bool status;
  VouchexVouchers vouchexVouchers;

  factory VouchexModel.fromJson(Map<String, dynamic> json) => VouchexModel(
    status: json["status"],
    vouchexVouchers: VouchexVouchers.fromJson(json["vouchex_vouchers"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vouchex_vouchers": vouchexVouchers.toJson(),
  };
}

class VouchexVouchers {
  VouchexVouchers({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.vLinks,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<VouchersData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<VouchexLinks> vLinks;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int to;
  int total;

  factory VouchexVouchers.fromJson(Map<String, dynamic> json) => VouchexVouchers(
    currentPage: json["current_page"],
    data: List<VouchersData>.from(json["data"].map((x) => VouchersData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    vLinks: List<VouchexLinks>.from(json["links"].map((x) => VouchexLinks.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(vLinks.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class VouchersData {
  VouchersData({
    required this.id,
    required this.uuId,
    required this.name,
    required this.code,
    required this.marketValue,
    required this.termsConditions,
    required this.isStatic,
    required this.expiry,
    this.userId,
    required this.isRedeemed,
    required this.isSwapped,
    required this.isVouchex,
    required this.profilePhotoPath,
    required this.coverPhotoPath,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.service,
  });

  int id;
  String uuId;
  String name;
  String code;
  String marketValue;
  String termsConditions;
  String isStatic;
  DateTime expiry;
  int? userId;
  String isRedeemed;
  String isSwapped;
  String isVouchex;
  String profilePhotoPath;
  String coverPhotoPath;
  DateTime createdAt;
  DateTime updatedAt;
  String? deletedAt;
  List<dynamic> service;

  factory VouchersData.fromJson(Map<String, dynamic> json) => VouchersData(
    id: json["id"],
    uuId: json["uu_id"],
    name: json["name"],
    code: json["code"],
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
    service: List<dynamic>.from(json["service"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uu_id": uuId,
    "name": name,
    "code": code,
    "market_value": marketValue,
    "terms_conditions": termsConditions,
    "is_static": isStatic,
    "expiry": "${expiry.year.toString().padLeft(4, '0')}-${expiry.month.toString().padLeft(2, '0')}-${expiry.day.toString().padLeft(2, '0')}",
    "user_id": userId,
    "is_redeemed": isRedeemed,
    "is_swapped": isSwapped,
    "is_vouchex": isVouchex,
    "profile_photo_path": profilePhotoPath,
    "cover_photo_path": coverPhotoPath,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "service": List<dynamic>.from(service.map((x) => x)),
  };
}

class VouchexLinks {
  VouchexLinks({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory VouchexLinks.fromJson(Map<String, dynamic> json) => VouchexLinks(
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
