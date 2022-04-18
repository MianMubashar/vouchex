import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
                    child: RefreshIndicator(
                      onRefresh: () async{
                        _getAllVouchers.fetchVouchers(isRefresh: true);
                      },
                      child: PagedListView<int, AllVouchersData>(
                        pagingController: _getAllVouchers.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<AllVouchersData>(
                            itemBuilder: (context, item, index) {
                              return Column(
                                children: [
                                  VoucherCard(model: item),
                                  if (index == _getAllVouchers.pagingController.itemList!.length - 1)
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      child: smallText("No More Data"),
                                    ),
                                ],
                              );
                            }
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          ),
      )
    );
  }
}
