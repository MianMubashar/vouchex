import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabs extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController controller;
  var currentIndex = 0.obs;

  final List<Tab> tabs = <Tab>[
    const Tab(
        text: 'Business '
    ),
    const Tab(
      text: 'Vouchers',
    )
  ];

  @override
  void onInit() {
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if(controller.indexIsChanging) {
        currentIndex.value = controller.index;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
