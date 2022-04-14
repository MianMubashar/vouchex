import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/modules/history/modules.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class FreeVouchers extends StatelessWidget {
   FreeVouchers({Key? key}) : super(key: key);

  final FreeVoucherController _freeVoucherController = Get.put(FreeVoucherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() =>
            ModalProgress(
              call: _freeVoucherController.isLoading.value,
              child: SafeArea(
                child: SmartRefresher(
                    controller: _freeVoucherController.refreshController,
                    enablePullUp: true,
                    onRefresh: () async {
                      final result = await _freeVoucherController.getFreeVouchers(isRefresh: true);
                      if (result) {
                        _freeVoucherController.refreshController.refreshCompleted();
                      } else {
                        _freeVoucherController.refreshController.refreshFailed();
                      }
                    },
                    onLoading: () async {
                      final result = await _freeVoucherController.getFreeVouchers();
                      if (result) {
                        _freeVoucherController.refreshController.loadComplete();
                      } else {
                        _freeVoucherController.refreshController.loadFailed();
                      }
                    },
                    child: _freeVoucherController.freeVoucherList.isNotEmpty ? ListView.builder(
                      itemCount: _freeVoucherController.freeVoucherList.length,
                      itemBuilder: (context, index) {
                        return
                          VoucherHistoryCard(model: _freeVoucherController.freeVoucherList[index]);
                      },
                    ) :
                    Center(
                      child: smallText(_freeVoucherController.noData.value),
                    )
                ),
              ),
            ),
        )
    );
  }
}
