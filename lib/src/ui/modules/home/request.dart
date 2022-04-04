import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';

import 'package:vouchex/src/data/model/models.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class RequestScreen extends StatelessWidget {
   RequestScreen({Key? key}) : super(key: key);

  final PendingExchangeRequestController _exchangeRequestController = Get.put(PendingExchangeRequestController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _exchangeRequestController.isLoading.value,
            child: SafeArea(
              child: Column(
                children: [
                  const CustomAppBar(
                    title: "Exchange Requests",
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: SmartRefresher(
                      controller: _exchangeRequestController.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await _exchangeRequestController.getPendingExchangeRequest(isRefresh: true);
                        if (result) {
                          _exchangeRequestController.refreshController.refreshCompleted();
                        } else {
                          _exchangeRequestController.refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await _exchangeRequestController.getPendingExchangeRequest();
                        if (result) {
                          _exchangeRequestController.refreshController.loadComplete();
                        } else {
                          _exchangeRequestController.refreshController.loadFailed();
                        }
                      },
                      child: ListView.builder(
                        itemCount: _exchangeRequestController.requesterVoucher.length,
                        itemBuilder: (context, index) {
                          return PendingRequestCard(model: _exchangeRequestController.requesterVoucher[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      )
    );
  }
}
