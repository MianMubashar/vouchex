import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/modules/history/modules.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class SwappedVoucher extends StatelessWidget {
   SwappedVoucher({Key? key}) : super(key: key);

   final MySwappedVoucherController _mySwappedVoucherController = Get.put(MySwappedVoucherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _mySwappedVoucherController.isLoading.value,
            child: SafeArea(
              child: SmartRefresher(
                controller: _mySwappedVoucherController.refreshController,
                enablePullUp: true,
                onRefresh: () async {
                  final result = await _mySwappedVoucherController.getMySwappedVouchers(isRefresh: true);
                  if (result) {
                    _mySwappedVoucherController.refreshController.refreshCompleted();
                  } else {
                    _mySwappedVoucherController.refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await _mySwappedVoucherController.getMySwappedVouchers();
                  if (result) {
                    _mySwappedVoucherController.refreshController.loadComplete();
                  } else {
                    _mySwappedVoucherController.refreshController.loadNoData();
                  }
                },
                child: _mySwappedVoucherController.swappedVoucherList.isNotEmpty ? ListView.builder(
                  itemCount: _mySwappedVoucherController.swappedVoucherList.length,
                  itemBuilder: (context, index) {
                    return
                      SwappedVoucherCard(model: _mySwappedVoucherController.swappedVoucherList[index]);
                  },
                ) :
                Center(
                  child: smallText(_mySwappedVoucherController.noData.value),
                )
              ),
            ),
          ),
      )
    );
  }
}
