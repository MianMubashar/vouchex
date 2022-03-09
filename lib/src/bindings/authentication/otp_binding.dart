import 'package:get/get.dart';
import '../../controllers/controllers.dart';


class OtpBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(OtpController());
  }

}