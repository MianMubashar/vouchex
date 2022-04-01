import 'dart:convert';

TermsConditionModel termsConditionModelFromJson(String str) => TermsConditionModel.fromJson(json.decode(str));

String termsConditionModelToJson(TermsConditionModel data) => json.encode(data.toJson());

class TermsConditionModel {
  TermsConditionModel({
    required this.status,
    required this.termConditions,
  });

  bool status;
  TermConditions termConditions;

  factory TermsConditionModel.fromJson(Map<String, dynamic> json) => TermsConditionModel(
    status: json["status"],
    termConditions: TermConditions.fromJson(json["term_conditions"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "term_conditions": termConditions.toJson(),
  };
}

class TermConditions {
  TermConditions({
    required this.id,
    required this.privacyPolicy,
    required this.termsConditions,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String privacyPolicy;
  String termsConditions;
  String? createdAt;
  String? updatedAt;

  factory TermConditions.fromJson(Map<String, dynamic> json) => TermConditions(
    id: json["id"],
    privacyPolicy: json["privacy_policy"],
    termsConditions: json["terms_conditions"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "privacy_policy": privacyPolicy,
    "terms_conditions": termsConditions,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
