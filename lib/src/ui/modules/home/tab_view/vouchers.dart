import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class VouchersScreen extends StatelessWidget {
   VouchersScreen({Key? key}) : super(key: key);

   final TextEditingController search = TextEditingController();
   final GetAllVouchersController _getAllVouchers = Get.put(GetAllVouchersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          SafeArea(
            child: ModalProgress(
              call: _getAllVouchers.isLoading.value,
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  Expanded(
                    child: /*SmartRefresher(
                      controller: _getAllVouchers.vouchersRefreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await _getAllVouchers.getAllVouchersDataData(isRefresh: true);
                        if (result) {
                          _getAllVouchers.vouchersRefreshController.refreshCompleted();
                        }
                      },
                      onLoading: () async {
                        final result = await _getAllVouchers.getAllVouchersDataData();
                        if (result) {
                          _getAllVouchers.vouchersRefreshController.loadComplete();
                        }
                      },
                      child: _getAllVouchers.vouchersList.isNotEmpty ? ListView.builder(
                        itemCount: _getAllVouchers.vouchersList.length,
                        itemBuilder: (context, index) {
                          return VoucherCard(model: _getAllVouchers.vouchersList[index]);
                        },
                      ) :
                      Center(
                        child: smallText(_getAllVouchers.noData.value),
                      )
                    ),*/
                    PagedListView<int, AllVouchersData>(
                      pagingController: _getAllVouchers.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<AllVouchersData>(
                          itemBuilder: (context, item, index) => VoucherCard(model: _getAllVouchers.vouchersList[index])
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
