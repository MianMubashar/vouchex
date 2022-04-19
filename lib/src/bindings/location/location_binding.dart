import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PickLocationController());
  }
}