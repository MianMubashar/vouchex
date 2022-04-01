import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class TermsConditionBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(TermsConditionsController());
  }

}