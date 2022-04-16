import 'dart:convert';

MySwappedVouchersModel mySwappedVouchersModelFromJson(String str) => MySwappedVouchersModel.fromJson(json.decode(str));

String mySwappedVouchersModelToJson(MySwappedVouchersModel data) => json.encode(data.toJson());

class MySwappedVouchersModel {
  MySwappedVouchersModel({
    this.status,
    this.swappedVouchers,
  });

  bool? status;
  SwappedVouchers? swappedVouchers;

  factory MySwappedVouchersModel.fromJson(Map<String, dynamic> json) => MySwappedVouchersModel(
    status: json["status"],
    swappedVouchers: json['swapped_vouchers'] != null
        ? SwappedVouchers.fromJson(json['swapped_vouchers'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "swapped_vouchers": swappedVouchers!.toJson(),
  };
}

class SwappedVouchers {
  SwappedVouchers({
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
    required this.total,
  });

  int? currentPage;
  List<SwappedVouchersList>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<SwappedVouchersLinks>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int total;

  factory SwappedVouchers.fromJson(Map<String, dynamic> json) => SwappedVouchers(
    currentPage: json["current_page"],
    data: json["data"] != null ? List<SwappedVouchersList>.from(json["data"].map((x) => SwappedVouchersList.fromJson(x))) : null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<SwappedVouchersLinks>.from(json["links"].map((x) => SwappedVouchersLinks.fromJson(x))),
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

class SwappedVouchersList {
  SwappedVouchersList({
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
    this.service,
    this.business
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
  DateTime?updatedAt;
  String? deletedAt;
  List<SwappedVouchersServices>? service;
  SwappedVoucherBusiness? business;

  factory SwappedVouchersList.fromJson(Map<String, dynamic> json) => SwappedVouchersList(
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
    service: List<SwappedVouchersServices>.from(json["service"].map((x) => SwappedVouchersServices.fromJson(x))),
    business: SwappedVoucherBusiness.fromJson(json["business"]),
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
    "service": List<dynamic>.from(service!.map((x) => x.toJson())),
    "business": business!.toJson(),
  };
}

class SwappedVoucherBusiness {
  SwappedVoucherBusiness({
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

  factory SwappedVoucherBusiness.fromJson(Map<String, dynamic> json) => SwappedVoucherBusiness(
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
  };
}

class SwappedVouchersServices {
  SwappedVouchersServices({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory SwappedVouchersServices.fromJson(Map<String, dynamic> json) => SwappedVouchersServices(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class SwappedVouchersLinks {
  SwappedVouchersLinks({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory SwappedVouchersLinks.fromJson(Map<String, dynamic> json) => SwappedVouchersLinks(
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
