import 'package:get/get.dart';

class VoucherDataController extends GetxController{
  var isVisible = true.obs;
  showHide() {
    isVisible.toggle();
  }
}