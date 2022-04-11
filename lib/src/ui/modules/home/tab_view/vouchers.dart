import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
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
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left:15, right: 15),
                  child: RoundedInputField(
                    textEditingController: search,
                    hintText: "Search Vouchers",
                    icon: Icons.search,
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  ),
                ),
                const SizedBox(height: 15,),
                Expanded(
                  child: SmartRefresher(
                    controller: _getAllVouchers.refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () async {
                      final result = await _getAllVouchers.getAllVouchersDataData(isRefresh: true);
                      if (result) {
                        _getAllVouchers.refreshController.refreshCompleted();
                      } else {
                        _getAllVouchers.refreshController.refreshFailed();
                      }
                    },
                    onLoading: () async {
                      final result = await _getAllVouchers.getAllVouchersDataData();
                      if (result) {
                        _getAllVouchers.refreshController.loadComplete();
                      } else {
                        _getAllVouchers.refreshController.loadFailed();
                      }
                    },
                    child: ListView.builder(
                      itemCount: _getAllVouchers.vouchersList.length,
                      itemBuilder: (context, index) {
                        return VoucherCard(model: _getAllVouchers.vouchersList[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
      )
    );
  }
}
