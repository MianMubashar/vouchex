import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class MyBusinessDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyBusinessDetailsController());
  }

}