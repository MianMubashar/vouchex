import 'dart:convert';

PendingExchangeRequestModel pendingExchangeRequestModelFromJson(String str) => PendingExchangeRequestModel.fromJson(json.decode(str));

String pendingExchangeRequestModelToJson(PendingExchangeRequestModel data) => json.encode(data.toJson());

class PendingExchangeRequestModel {
  PendingExchangeRequestModel({
    this.status,
    this.pendingExchangeRequests,
  });

  bool? status;
  PendingExchangeRequests? pendingExchangeRequests;

  factory PendingExchangeRequestModel.fromJson(Map<String, dynamic> json) => PendingExchangeRequestModel(
    status: json["status"],
    pendingExchangeRequests: json['pending_exchange_requests'] != null
        ? PendingExchangeRequests.fromJson(json['pending_exchange_requests'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pending_exchange_requests": pendingExchangeRequests!.toJson(),
  };
}

class PendingExchangeRequests {
  PendingExchangeRequests({
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
  List<PEData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<PELinks>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory PendingExchangeRequests.fromJson(Map<String, dynamic> json) => PendingExchangeRequests(
    currentPage: json["current_page"],
    data: json["data"] != null ? List<PEData>.from(json["data"].map((x) => PEData.fromJson(x))) : null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<PELinks>.from(json["links"].map((x) => PELinks.fromJson(x))),
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

class PEData {
  PEData({
    this.id,
    this.requesterId,
    this.requesterVoucherId,
    this.requesteeId,
    this.requesteeVoucherId,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.isRedeemed,
    this.requester,
    this.requesteeVoucher,
    this.requesterVoucher,
  });

  int? id;
  int? requesterId;
  int? requesterVoucherId;
  int? requesteeId;
  int? requesteeVoucherId;
  int? statusId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? isRedeemed;
  Requester? requester;
  RequesteeVoucher? requesteeVoucher;
  RequesterVoucher? requesterVoucher;

  factory PEData.fromJson(Map<String, dynamic> json) => PEData(
    id: json["id"],
    requesterId: json["requester_id"],
    requesterVoucherId: json["requester_voucher_id"],
    requesteeId: json["requestee_id"],
    requesteeVoucherId: json["requestee_voucher_id"],
    statusId: json["status_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isRedeemed: json["is_redeemed"],
    requester: json["requester"] != null ? Requester.fromJson(json["requester"]) : null,
    requesteeVoucher: RequesteeVoucher.fromJson(json['requestee_voucher']),
    requesterVoucher: json["requester_voucher"] != null ? RequesterVoucher.fromJson(json["requester_voucher"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "requester_id": requesterId,
    "requester_voucher_id": requesterVoucherId,
    "requestee_id": requesteeId,
    "requestee_voucher_id": requesteeVoucherId,
    "status_id": statusId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "is_redeemed": isRedeemed,
    "requester": requester!.toJson(),
    "requestee_voucher": requesteeVoucher,
    "requester_voucher": requesterVoucher!.toJson(),
  };
}

class Requester {
  Requester({
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
    this.business
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
  RequesterBusiness? business;

  factory Requester.fromJson(Map<String, dynamic> json) => Requester(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    deviceToken: json["device_token"],
    profilePhotoPath: json["profile_photo_path"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    roleId: json["role_id"],
    countryCode: json["country_code"],
    businessId: json["business_id"],
    profilePhotoUrl: json["profile_photo_url"],
    business: RequesterBusiness.fromJson(json["business"]),
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

class RequesterBusiness {
  RequesterBusiness({
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

  factory RequesterBusiness.fromJson(Map<String, dynamic> json) => RequesterBusiness(
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

class RequesterVoucher {
  RequesterVoucher({
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
  DateTime? deletedAt;

  factory RequesterVoucher.fromJson(Map<String, dynamic> json) => RequesterVoucher(
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
  };
}
class RequesteeVoucher {
  RequesteeVoucher({
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
  DateTime? deletedAt;

  factory RequesteeVoucher.fromJson(Map<String, dynamic> json) => RequesteeVoucher(
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
  };
}

class PELinks {
  PELinks({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory PELinks.fromJson(Map<String, dynamic> json) => PELinks(
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
