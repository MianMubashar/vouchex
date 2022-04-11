import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class EditBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditBusinessController());
  }

}