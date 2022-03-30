import 'dart:convert';

GetServices getServicesFromJson(String str) => GetServices.fromJson(json.decode(str));

String getServicesToJson(GetServices data) => json.encode(data.toJson());

class GetServices {
  GetServices({
    required this.status,
    required this.services,
  });

  bool status;
  List<Service> services;

  factory GetServices.fromJson(Map<String, dynamic> json) => GetServices(
    status: json["status"],
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

class Service {
  Service({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
