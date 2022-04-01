import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ContactUsController());
  }

}