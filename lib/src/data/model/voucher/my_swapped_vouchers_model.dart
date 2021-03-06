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
    to: json["to"] ?? 0,
    total: json["total"] ?? 0,
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
    this.requestee,
    this.requesteeVoucher,
    this.requesterVoucher
    //this.service,
    //this.business
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
  Requestee? requestee;
  RequesteeVoucher? requesteeVoucher;
  RequesterVoucher? requesterVoucher;

  //List<SwappedVouchersServices>? service;
  //SwappedVoucherBusiness? business;

  factory SwappedVouchersList.fromJson(Map<String, dynamic> json) => SwappedVouchersList(
    id: json["id"],
    uuId: json["uu_id"],
    name: json["name"],
    code: json["code"],
    isFree: json["is_free"],
    marketValue: json["market_value"],
    termsConditions: json["terms_conditions"],
    isStatic: json["is_static"],
    expiry: json["expiry"] != null ? DateTime.parse(json["expiry"]) : DateTime.now() ,
    userId: json["user_id"],
    isRedeemed: json["is_redeemed"],
    isSwapped: json["is_swapped"],
    isVouchex: json["is_vouchex"],
    profilePhotoPath: json["profile_photo_path"],
    coverPhotoPath: json["cover_photo_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    requestee: json['requestee'] != null ? Requestee.fromJson(json['requestee']): null,
    requesteeVoucher: json['requestee_voucher'] != null ? RequesteeVoucher.fromJson(json['requestee_voucher']) : null,
    requesterVoucher: json['requester_voucher'] != null ? RequesterVoucher.fromJson(json['requester_voucher']) : null
    //service: json["service"] != null ? List<SwappedVouchersServices>.from(json["service"].map((x) => SwappedVouchersServices.fromJson(x))) : null,
    //business: json["business"] != null ? SwappedVoucherBusiness.fromJson(json["business"]) : null,
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
    "requestee": requestee,
    "requestee_voucher":requesteeVoucher,
    "requester_voucher": requesterVoucher,
    //"service": List<dynamic>.from(service!.map((x) => x.toJson())),
    //"business": business!.toJson(),
  };
}
class Requestee {
  Requestee({
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
  RequesteeBusiness? business;

  factory Requestee.fromJson(Map<String, dynamic> json) => Requestee(
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
    business: RequesteeBusiness.fromJson(json["business"]),
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

class RequesteeBusiness {
  RequesteeBusiness({
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

  factory RequesteeBusiness.fromJson(Map<String, dynamic> json) => RequesteeBusiness(
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
    this.services
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
  List<Services>? services;

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
    services: json['service'] != null ? List<Services>.from(json['service'].map((e)=>Services.fromJson(e))) : null
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
    this.services
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
  List<Services>? services;

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
    services: json['service'] != null ? List<Services>.from(json['service'].map((e)=>Services.fromJson(e))): null
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

class Services{
  int? id;
  String? title;
  int? user_id;

  Services({required this.id,required this.title,required this.user_id});
  factory Services.fromJson(Map<String, dynamic> data){
    return Services(id: data['id'], title: data['title'], user_id: data['user_id']);
  }
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
