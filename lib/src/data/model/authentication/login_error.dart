import 'dart:convert';

LoginErrorResponse loginErrorResponseFromJson(String str) => LoginErrorResponse.fromJson(json.decode(str));

String loginErrorResponseToJson(LoginErrorResponse data) => json.encode(data.toJson());

class LoginErrorResponse {
  LoginErrorResponse({
    required this.status,
    required this.error,
  });

  bool status;
  Error error;

  factory LoginErrorResponse.fromJson(Map<String, dynamic> json) => LoginErrorResponse(
    status: json["status"],
    error: Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error.toJson(),
  };
}

class Error {
  Error({
    this.phoneNo,
    this.deviceToken,
    this.countryCode,
  });

  List<String>? phoneNo;
  List<String>? deviceToken;
  List<String>? countryCode;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    phoneNo: List<String>.from(json["phone_no"].map((x) => x)),
    deviceToken: List<String>.from(json["device_token"].map((x) => x)),
    countryCode: List<String>.from(json["country_code"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "phone_no": List<dynamic>.from(phoneNo!.map((x) => x)),
    "device_token": List<dynamic>.from(deviceToken!.map((x) => x)),
    "country_code": List<dynamic>.from(countryCode!.map((x) => x)),
  };
}
