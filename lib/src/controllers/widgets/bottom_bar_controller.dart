import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

/*  bool isUserLoggedIn() {
    var user = _firebaseAuth.currentUser;
    return !(user == null);
  }*/
  bool isUserLoggedIn() {
    final loginCredentials = GetStorage();
    var id = loginCredentials.read("userId");
    print(id);
    var email = loginCredentials.read("email");
    print(email);
    return !(id == null && email == null);
  }

  @override
  void dispose() {
    super.dispose();
    selectedPage.close();
    tabController.dispose();
  }
}
