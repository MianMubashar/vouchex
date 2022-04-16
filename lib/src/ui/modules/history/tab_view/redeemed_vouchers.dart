import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/history/modules.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/modal_progress.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class RedeemedVouchers extends StatelessWidget {
   RedeemedVouchers({Key? key}) : super(key: key);

   final MyRedeemedVoucherController _myRedeemedVoucherController = Get.put(MyRedeemedVoucherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _myRedeemedVoucherController.isLoading.value,
            child: SafeArea(
              child: SmartRefresher(
                controller: _myRedeemedVoucherController.refreshController,
                enablePullUp: true,
                onRefresh: () async {
                  final result = await _myRedeemedVoucherController.getMyRedeemedVouchers(isRefresh: true);
                  if (result) {
                    _myRedeemedVoucherController.refreshController.refreshCompleted();
                  } else {
                    _myRedeemedVoucherController.refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await _myRedeemedVoucherController.getMyRedeemedVouchers();
                  if (result) {
                    _myRedeemedVoucherController.refreshController.loadComplete();
                  } else {
                    _myRedeemedVoucherController.refreshController.loadFailed();
                  }
                },
                child: _myRedeemedVoucherController.redeemedVouchersList!.isNotEmpty ? ListView.builder(
                  itemCount: _myRedeemedVoucherController.redeemedVouchersList!.length,
                  itemBuilder: (context, index) {
                    return SwappedVoucherCard(model: _myRedeemedVoucherController.redeemedVouchersList![index]);
                  },
                ) : Center(
                  child: smallText(_myRedeemedVoucherController.noData.value),
                )
              ),
            ),
          ),
      )
    );
  }
}
