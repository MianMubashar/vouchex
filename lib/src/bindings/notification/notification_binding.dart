import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}