import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomBarController extends GetxController {
  var selectedPage = 0.obs;
  late PersistentTabController tabController;
  final _firebaseAuth = FirebaseAuth.instance;

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

  bool isUserLoggedIn() {
    var user = _firebaseAuth.currentUser;
    return !(user == null);
  }

  @override
  void dispose() {
    super.dispose();
    selectedPage.close();
    tabController.dispose();
  }
}
