import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class HistoryTabViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HistoryTabs());
  }

}