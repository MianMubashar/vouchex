
import 'dart:convert';

GetAllVouchers getAllVouchersFromJson(String str) => GetAllVouchers.fromJson(json.decode(str));

String getAllVouchersToJson(GetAllVouchers data) => json.encode(data.toJson());

class GetAllVouchers {
  GetAllVouchers({
    this.status,
    this.vouchers,
  });

  bool? status;
  AllVouchers? vouchers;

  factory GetAllVouchers.fromJson(Map<String, dynamic> json) => GetAllVouchers(
    status: json["status"],
    vouchers: json['vouchers'] != null
        ? AllVouchers.fromJson(json['vouchers'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vouchers": vouchers!.toJson(),
  };
}

class AllVouchers {
  AllVouchers({
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
  List<AllVouchersData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<AllVoucherLinks>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory AllVouchers.fromJson(Map<String, dynamic> json) => AllVouchers(
    currentPage: json["current_page"],
    data: json["data"] != null ? List<AllVouchersData>.from(json["data"].map((x) => AllVouchersData.fromJson(x))) : null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] != null ? List<AllVoucherLinks>.from(json["links"].map((x) => AllVoucherLinks.fromJson(x))) : null,
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

class AllVouchersData {
  AllVouchersData({
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
    this.buisness
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
  List<AllVoucherServices>? service;
  AllVoucherBuisness? buisness;

  factory AllVouchersData.fromJson(Map<String, dynamic> json) => AllVouchersData(
    id: json["id"],
    uuId: json["uu_id"],
    name: json["name"],
    code: json["code"] ?? "",
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
    service: json["service"] != null ? List<AllVoucherServices>.from(json["service"].map((x) => AllVoucherServices.fromJson(x))) : null,
    buisness: AllVoucherBuisness.fromJson(json['business'])

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
    // "business":
  };
}

class AllVoucherServices {
  AllVoucherServices({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory AllVoucherServices.fromJson(Map<String, dynamic> json) => AllVoucherServices(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class AllVoucherLinks {
  AllVoucherLinks({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory AllVoucherLinks.fromJson(Map<String, dynamic> json) => AllVoucherLinks(
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

class AllVoucherBuisness{
  int? id;
  String? name;
  String? description;
  String? cover_photo_path;
  String? profile_photo_path;
  int? business_type_id;
  String? created_at;
  String? updated_at;
  String? email;
  String? phone_no;

  AllVoucherBuisness({this.id,this.name,this.description,this.cover_photo_path,this.profile_photo_path,this.business_type_id,
  this.created_at,this.updated_at,this.email,this.phone_no});

  factory AllVoucherBuisness.fromJson(Map<String, dynamic> data){
    return AllVoucherBuisness(id: data['id'],name: data['name'],description: data['description'],cover_photo_path: data['cover_photo_path'],
    profile_photo_path: data['profile_photo_path'],business_type_id:data['business_type_id'],created_at: data['created_at'],
    updated_at: data['updated_at'],email: data['email'],phone_no: data['phone_no']);
  }
}
