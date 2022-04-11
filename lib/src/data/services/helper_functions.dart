import 'package:get_storage/get_storage.dart';

class HelperFunctions{
  final loginDetails = GetStorage();

  saveUserToken(String token) {
    return loginDetails.write("token", token);
  }

  saveUserId(int uid) {
    return loginDetails.write("userId", uid);
  }
}