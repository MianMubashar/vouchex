import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVouchersTabs extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController myVouchersTabController;
  var currentIndex = 0.obs;

  final List<Tab> tabs = <Tab>[
    const Tab(
        text: 'My Vouchers'
    ),
    const Tab(
      text: 'Swapped Vouchers',
    ),
    const Tab(
      text: 'Create a Voucher',
    )
  ];

  @override
  void onInit() {
    myVouchersTabController = TabController(length: 3, vsync: this);
    myVouchersTabController.addListener(() {
      if(myVouchersTabController.indexIsChanging) {
        currentIndex.value = myVouchersTabController.index;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    myVouchersTabController.dispose();
    super.onClose();
  }
}
