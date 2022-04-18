import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class SentPendingRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SentPendingRequestController());
  }

}