import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/vouchers/request_voucher_exchange_controller.dart';
import 'package:vouchex/src/ui/modules/my_vouchers/widgets/my_voucher_card.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/modal_progress.dart';

import '../../widgets/custom_widgets/app_bar.dart';

class VoucherList extends StatelessWidget {
  VoucherList({Key? key}) : super(key: key);

  final RequestVoucherExchangeController _requestVoucherExchangeController = Get.put(RequestVoucherExchangeController());
  int? userId = Get.arguments['userId'];
  int? voucherId = Get.arguments['voucherId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "Vouchers to be swapped",
                showLeadingIcon: true,
                leadingIconPressed: () {Get.back();} ,
              ),
              Expanded(
                child: Obx(() =>
                    ModalProgress(
                      call: _requestVoucherExchangeController.isLoading.value,
                      child: SafeArea(
                        child: SmartRefresher(
                          controller: _requestVoucherExchangeController.refreshController,
                          enablePullUp: true,
                          enablePullDown: true,
                          onRefresh: () async {
                            final result = await _requestVoucherExchangeController.getMyVouchers(isRefresh: true);
                            if (result) {
                              _requestVoucherExchangeController.refreshController.refreshCompleted();
                            }
                          },
                          onLoading: () async {
                            final result = await _requestVoucherExchangeController.getMyVouchers();
                            if (result) {
                              _requestVoucherExchangeController.refreshController.loadComplete();
                            }
                          },
                          child: ListView.builder(
                            itemCount: _requestVoucherExchangeController.myVouchersList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async{
                                  print(_requestVoucherExchangeController.myVouchersList[index].id);
                                 await _requestVoucherExchangeController.requestVoucherExchange(
                                   context,
                                     _requestVoucherExchangeController.myVouchersList[index].id,
                                      userId,
                                      voucherId);
                                // Get.back(closeOverlays: true);
                                },
                                  child: VoucherListCard(model: _requestVoucherExchangeController.myVouchersList[index],));
                            },
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
