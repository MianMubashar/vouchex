import 'package:get/get.dart';

import '../controllers.dart';

class VoucherDataController extends GetxController{

  var isVisible = true.obs;
  final GetAllVouchersController _getAllVouchers = Get.put(GetAllVouchersController());
  showHide() {
    isVisible.toggle();
  }



}