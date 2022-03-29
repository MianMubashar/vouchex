import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class VouchexBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VouchexVouchersController());
  }

}