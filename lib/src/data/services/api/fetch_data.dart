import 'dart:convert';

import 'package:http/http.dart' as http;


class GetDataFromAPI {
  static var client = http.Client();
  static Future<String?> fetchData(String data, String token) async{
    var response  = await client.post(Uri.parse(data),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      },
    );
    if(response.statusCode == 200 && response.body.isNotEmpty) {
      print(response.statusCode);
      print(response.body);
      return response.body;
    }
    else {
      return null;
    }
  }
}
