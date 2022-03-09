import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomBarController());
  }
}
