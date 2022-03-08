import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{
  var currentIndex = 0.obs;
  PageController controller = PageController();

  @override
  void onInit() {
    controller = PageController(initialPage: 0);
    super.onInit();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}