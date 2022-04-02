import 'dart:convert';

GetBusinessTypes getBusinessTypesFromJson(String str) => GetBusinessTypes.fromJson(json.decode(str));

String getBusinessTypesToJson(GetBusinessTypes data) => json.encode(data.toJson());

class GetBusinessTypes {
  GetBusinessTypes({
    required this.status,
    required this.businesses,
  });

  bool status;
  List<Business> businesses;

  factory GetBusinessTypes.fromJson(Map<String, dynamic> json) => GetBusinessTypes(
    status: json["status"],
    businesses: List<Business>.from(json["businesses"].map((x) => Business.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
  };
}

class Business {
  Business({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
