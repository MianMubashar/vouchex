import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';

class SearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchResultController());
  }
}