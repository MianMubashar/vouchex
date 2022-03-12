import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryTabs extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController historyTabController;
  var currentIndex = 0.obs;

  final List<Tab> tabs = <Tab>[
    const Tab(
        text: 'Expired'
    ),
    const Tab(
      text: 'Redeemed',
    )
  ];

  @override
  void onInit() {
    historyTabController = TabController(length: 2, vsync: this);
    historyTabController.addListener(() {
      if(historyTabController.indexIsChanging) {
        currentIndex.value = historyTabController.index;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    historyTabController.dispose();
    super.onClose();
  }
}
