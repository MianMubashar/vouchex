import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class MyVouchersTabViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MyVouchersTabs());
  }

}