import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/controllers/vouchers/request_voucher_exchange_controller.dart';
import 'package:vouchex/src/ui/modules/my_vouchers/widgets/my_voucher_card.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/modal_progress.dart';

import '../../widgets/custom_widgets/app_bar.dart';

class VoucherList extends StatelessWidget {
  VoucherList({Key? key}) : super(key: key);

  final MyVoucherController _myVoucherController = Get.put(MyVoucherController());
  final RequestVoucherExchangeController _requestVoucherExchangeController=Get.put(RequestVoucherExchangeController());
  int? userId=Get.arguments['userId'];
  int? voucherId=Get.arguments['voucherId'];
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
                      call: _myVoucherController.isLoading.value,
                      child: SafeArea(
                        child: SmartRefresher(
                          controller: _myVoucherController.refreshController,
                          enablePullUp: true,
                          enablePullDown: true,
                          onRefresh: () async {
                            final result = await _myVoucherController.getMyVouchers(isRefresh: true);
                            if (result) {
                              _myVoucherController.refreshController.refreshCompleted();
                            } else {
                              _myVoucherController.refreshController.refreshFailed();
                            }
                          },
                          onLoading: () async {
                            final result = await _myVoucherController.getMyVouchers();
                            if (result) {
                              _myVoucherController.refreshController.loadComplete();
                            } else {
                              _myVoucherController.refreshController.loadFailed();
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _myVoucherController.myVouchersList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async{
                                          print(_myVoucherController.myVouchersList[index].id);
                                         await _requestVoucherExchangeController.requestVoucherExchange(
                                           context,
                                          _myVoucherController.myVouchersList[index].id,
                                              userId,
                                              voucherId);
                                        // Get.back(closeOverlays: true);
                                        },
                                          child: MyVoucherCard(model: _myVoucherController.myVouchersList[index],fromScreen: 'voucherList',));
                                    },
                                  ),
                                ),
                              ],
                            ),
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
