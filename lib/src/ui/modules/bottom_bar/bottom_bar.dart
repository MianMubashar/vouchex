import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vouchex/src/controllers/widgets/bottom_bar_controller.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/modules/home/home.dart';
import 'package:vouchex/src/ui/modules/home/request.dart';
import 'package:vouchex/src/ui/modules/home/scan_qr.dart';
import 'package:vouchex/src/ui/modules/home/search.dart';

class BottomBar extends StatelessWidget {
  BottomBar({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      RequestScreen(),
      ScanQRScreen(),
      SearchScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: 'Home',
        textStyle: const TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: bottomBarInactiveIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.repeat_outlined),
        title: 'Request',
        textStyle: const TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: bottomBarInactiveIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.qr_code_scanner_outlined),
        title: 'Scan QR',
        textStyle: const TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: bottomBarInactiveIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: 'Search',
        textStyle: const TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: bottomBarInactiveIconColor,
      ),
    ];
  }

  final BottomBarController _bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: PersistentTabView(
          context,
          screens: _buildScreens(),
          items: _navBarsItems(),
          onItemSelected: (index) {
            _bottomBarController.selectedPage(index);
          },
          controller: _bottomBarController.tabController,
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : kBottomNavigationBarHeight,
          hideNavigationBarWhenKeyboardShows: true,
          margin: const EdgeInsets.all(0.0),
          popActionScreens: PopActionScreensType.all,
          bottomScreenMargin: 0.0,
          hideNavigationBar: false,
          decoration: const NavBarDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(3, 3), // Shadow position
              ),
            ],
            colorBehindNavBar: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16)
            ),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style6,
        ),
      ),
    );
  }
}
