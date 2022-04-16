import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/modules/history/modules.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class ExpiredVouchers extends StatelessWidget {
   ExpiredVouchers({Key? key}) : super(key: key);

   final ExpiredVoucherController _expiredVoucherController = Get.put(ExpiredVoucherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _expiredVoucherController.isLoading.value,
            child: SafeArea(
              child: SmartRefresher(
                controller: _expiredVoucherController.refreshController,
                enablePullUp: true,
                onRefresh: () async {
                  final result = await _expiredVoucherController.getMyExpiredVouchers(isRefresh: true);
                  if (result) {
                    _expiredVoucherController.refreshController.refreshCompleted();
                  } else {
                    _expiredVoucherController.refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await _expiredVoucherController.getMyExpiredVouchers();
                  if (result) {
                    _expiredVoucherController.refreshController.loadComplete();
                  } else {
                    _expiredVoucherController.refreshController.loadFailed();
                  }
                },
                child: _expiredVoucherController.expiredVouchersList!.isNotEmpty ? ListView.builder(
                  itemCount: _expiredVoucherController.expiredVouchersList!.length,
                  itemBuilder: (context, index) {
                    return VoucherHistoryCard(model: _expiredVoucherController.expiredVouchersList![index]);
                  },
                ) : Center(
                  child: smallText(_expiredVoucherController.noData.value),
                )
              ),
            ),
          ),
      )
    );
  }
}
