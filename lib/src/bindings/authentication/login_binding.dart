import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}