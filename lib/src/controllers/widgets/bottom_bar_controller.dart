import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomBarController extends GetxController {
  var selectedPage = 0.obs;
  late PersistentTabController tabController;

  @override
  void onInit() {
    tabController = PersistentTabController(
      initialIndex: selectedPage.value,
    );
    selectedPage.listen(onIndexChange);
    super.onInit();
  }

  onIndexChange(int changedIndex) {
    tabController.index = changedIndex;
  }

  @override
  void dispose() {
    super.dispose();
    selectedPage.close();
  }
}
