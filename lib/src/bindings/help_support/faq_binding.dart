import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/controllers/help_support/faq_controller.dart';

class FAQBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FaqController());
  }

}