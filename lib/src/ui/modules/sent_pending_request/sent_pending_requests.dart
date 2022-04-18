import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import '../history/modules.dart';

class SentPendingRequests extends StatelessWidget {
   SentPendingRequests({Key? key}) : super(key: key);

  final SentPendingRequestController _pendingRequestController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() =>
            ModalProgress(
              call: _pendingRequestController.isLoading.value,
              child: SafeArea(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: "Pending Requests",
                      showLeadingIcon: true,
                      leadingIconPressed: () {Get.back();} ,
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: SmartRefresher(
                          controller: _pendingRequestController.refreshController,
                          enablePullUp: true,
                          onRefresh: () async {
                            final result = await _pendingRequestController.getSentPendingRequests(isRefresh: true);
                            if (result) {
                              _pendingRequestController.refreshController.refreshCompleted();
                            } else {
                              _pendingRequestController.refreshController.refreshFailed();
                            }
                          },
                          onLoading: () async {
                            final result = await _pendingRequestController.getSentPendingRequests();
                            if (result) {
                              _pendingRequestController.refreshController.loadComplete();
                            }
                          },
                          child: _pendingRequestController.sentPendingRequestList.isNotEmpty ?
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _pendingRequestController.sentPendingRequestList.length,
                            itemBuilder: (context, index) {
                              return
                                SwappedVoucherCard(model: _pendingRequestController.sentPendingRequestList[index]);
                            },
                          ) :
                          Center(
                            child: smallText(_pendingRequestController.noData.value),
                          )
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
