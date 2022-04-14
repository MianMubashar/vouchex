// To parse this JSON data, do
//
//     final voucherHistoryModel = voucherHistoryModelFromJson(jsonString);

import 'dart:convert';

VoucherHistoryModel voucherHistoryModelFromJson(String str) => VoucherHistoryModel.fromJson(json.decode(str));

String voucherHistoryModelToJson(VoucherHistoryModel data) => json.encode(data.toJson());

class VoucherHistoryModel {
  VoucherHistoryModel({
    this.status,
    this.vouchers,
  });

  bool? status;
  MyVouchersHistory?  vouchers;

  factory VoucherHistoryModel.fromJson(Map<String, dynamic> json) => VoucherHistoryModel(
    status: json["status"],
    vouchers: json['vouchers'] != null
        ? MyVouchersHistory.fromJson(json['vouchers'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vouchers": vouchers!.toJson(),
  };
}

class MyVouchersHistory {
  MyVouchersHistory({
    required this.currentPage,
    this.data,
    required this.firstPageUrl,
    this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
  });

  int currentPage;
  List<VoucherHistoryData>? data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String lastPageUrl;
  List<VoucherHistoryLinks> links;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int? to;
  int total;

  factory MyVouchersHistory.fromJson(Map<String, dynamic> json) => MyVouchersHistory(
    currentPage: json["current_page"],
    data: json["data"] != null ? List<VoucherHistoryData>.from(json["data"].map((x) => VoucherHistoryData.fromJson(x))) : null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<VoucherHistoryLinks>.from(json["links"].map((x) => VoucherHistoryLinks.fromJson(x))),
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

class VoucherHistoryData {
  VoucherHistoryData({
    required this.id,
    required this.uuId,
    required this.name,
    required this.code,
    required this.isFree,
    required this.marketValue,
    required this.termsConditions,
    required this.isStatic,
    required this.expiry,
    required this.userId,
    required this.isRedeemed,
    required this.isSwapped,
    required this.isVouchex,
    required this.profilePhotoPath,
    required this.coverPhotoPath,
    required this.createdAt,
    required this.service,
  });

  int id;
  String uuId;
  String name;
  String code;
  int isFree;
  String marketValue;
  String termsConditions;
  String isStatic;
  DateTime expiry;
  int userId;
  String isRedeemed;
  String isSwapped;
  String isVouchex;
  String profilePhotoPath;
  String coverPhotoPath;
  DateTime createdAt;
  List<VoucherHistoryServices> service;

  factory VoucherHistoryData.fromJson(Map<String, dynamic> json) => VoucherHistoryData(
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
    service: List<VoucherHistoryServices>.from(json["service"].map((x) => VoucherHistoryServices.fromJson(x))),
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
    "expiry": "${expiry.year.toString().padLeft(4, '0')}-${expiry.month.toString().padLeft(2, '0')}-${expiry.day.toString().padLeft(2, '0')}",
    "user_id": userId,
    "is_redeemed": isRedeemed,
    "is_swapped": isSwapped,
    "is_vouchex": isVouchex,
    "profile_photo_path": profilePhotoPath,
    "cover_photo_path": coverPhotoPath,
    "created_at": createdAt.toIso8601String(),
    "service": List<dynamic>.from(service.map((x) => x.toJson())),
  };
}

class VoucherHistoryServices {
  VoucherHistoryServices({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory VoucherHistoryServices.fromJson(Map<String, dynamic> json) => VoucherHistoryServices(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class VoucherHistoryLinks {
  VoucherHistoryLinks({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory VoucherHistoryLinks.fromJson(Map<String, dynamic> json) => VoucherHistoryLinks(
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
