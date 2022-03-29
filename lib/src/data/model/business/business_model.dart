import 'dart:convert';

class BusinessModel{
  final String email;
  final String contactNumber;
  final String businessType;
  final String description;
  final String backgroundImage;
  final String circleImage;
  final String title;
  final String subtitle;
  final String itemImage;

  BusinessModel({
    required this.email,
    required this.contactNumber,
    required this.businessType,
    required this.description,
    required this.backgroundImage,
    required this.circleImage,
    required this.title,
    required this.subtitle,
    required this.itemImage
  });
}

List<BusinessModel> businessList = <BusinessModel>[
  BusinessModel(
      backgroundImage: "assets/images/v_bg_1.png",
      circleImage: "assets/images/voucher_img_1.png",
      title: "Adidas",
      email: "adidas@gmail.com",
      contactNumber: "+123456789",
      businessType: "Sportswear",
      description: "Adidas want to exchange voucher with design services. we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.",
      subtitle: "It is the largest sportswear manufacturer in\nEurope, and the second largest in the world.",
      itemImage: "assets/images/item_img_1.png"),
  BusinessModel(
      backgroundImage: "assets/images/v_bg_2.png",
      circleImage: "assets/images/voucher_img_2.png",
      title: "KFC",
      email: "kfc@gmail.com",
      contactNumber: "+123456789",
      businessType: "Restaurant",
      description: "Adidas want to exchange voucher with design services. we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.",
      subtitle: "KFC is an American fast food restaurant headquartered\nin Louisville, Kentucky that specializes in fried chicken.", itemImage: "assets/images/item_img_2.png"),
];


GetBusinessesModel getBusinessesModelFromJson(String str) => GetBusinessesModel.fromJson(json.decode(str));

String getBusinessesModelToJson(GetBusinessesModel data) => json.encode(data.toJson());

class GetBusinessesModel {
  GetBusinessesModel({
    required this.status,
    required this.businesses,
  });

  bool status;
  Businesses businesses;

  factory GetBusinessesModel.fromJson(Map<String, dynamic> json) => GetBusinessesModel(
    status: json["status"],
    businesses: Businesses.fromJson(json["businesses"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "businesses": businesses.toJson(),
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
  List<Datum> data;
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
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
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

