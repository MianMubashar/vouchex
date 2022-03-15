import 'package:get/get.dart';
import '../../controllers/controllers.dart';


class PhoneBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PhoneController());
  }

}