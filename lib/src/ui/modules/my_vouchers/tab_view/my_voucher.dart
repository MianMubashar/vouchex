import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/modules/my_vouchers/widgets/my_voucher_card.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/text_widgets.dart';

class MyVoucher extends StatelessWidget {
   MyVoucher({Key? key}) : super(key: key);

  final MyVoucherController _myVoucherController = Get.put(MyVoucherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          SafeArea(
            child: SmartRefresher(
              controller: _myVoucherController.myVouchersRefreshController,
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () async {
                final result = await _myVoucherController.getMyVouchers(isRefresh: true);
                if (result) {
                  _myVoucherController.myVouchersRefreshController.refreshCompleted();
                }
              },
              onLoading: () async {
                final result = await _myVoucherController.getMyVouchers();
                if (result) {
                  _myVoucherController.myVouchersRefreshController.loadComplete();
                }
              },
              child: _myVoucherController.myVouchersList.isNotEmpty ? ListView.builder(
                itemCount: _myVoucherController.myVouchersList.length,
                itemBuilder: (context, index) {
                  return MyVoucherCard(model: _myVoucherController.myVouchersList[index]);
                },
              ) : Center(
                child: smallText(_myVoucherController.noData.value),
              ),
            ),
          ),
      )
    );
  }
}
