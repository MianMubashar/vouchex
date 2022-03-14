import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class CreateNewVoucherBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateVoucherController());
  }
}