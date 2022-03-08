import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class MainBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(OnBoardingController());
  }
}