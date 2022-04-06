import 'package:get/get.dart';
import 'package:vouchex/src/controllers/about_us/about_controller.dart';

class AboutusBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AboutusController());
  }

}