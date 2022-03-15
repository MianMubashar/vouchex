import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class CreateBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateBusinessController());
  }
}