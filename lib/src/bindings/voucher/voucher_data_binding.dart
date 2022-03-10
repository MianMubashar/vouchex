import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class VoucherDataBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(VoucherDataController());
  }

}