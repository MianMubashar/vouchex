import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/vouchex_vouchers/widget/vouchex_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../home/widgets/voucher_card.dart';


class VouchexVouchers extends StatelessWidget {
   VouchexVouchers({Key? key}) : super(key: key);

   final TextEditingController _search = TextEditingController();
   final VouchexVouchersController _vouchersController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _vouchersController.isLoading.value,
            child: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    title: "Vouchex Vouchers",
                    showLeadingIcon: true,
                    leadingIconPressed: () {Get.back();} ,
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left:15, right: 15),
                    child: RoundedInputField(
                      textEditingController: _search,
                      hintText: "Search Businesses",
                      icon: Icons.search,
                      fillColor: Colors.white,
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Expanded(
                    child: SmartRefresher(
                      controller: _vouchersController.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await _vouchersController.getVouchexData(isRefresh: true);
                        if (result) {
                          _vouchersController.refreshController.refreshCompleted();
                        } else {
                          _vouchersController.refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await _vouchersController.getVouchexData();
                        if (result) {
                          _vouchersController.refreshController.loadComplete();
                        } else {
                          _vouchersController.refreshController.loadFailed();
                        }
                      },
                      child: _vouchersController.vouchexList.isNotEmpty ? Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListView.builder(
                          itemCount: _vouchersController.vouchexList.length,
                          itemBuilder: (context, index) {
                            return VouchexCard(model: _vouchersController.vouchexList[index]);
                          },
                        ),
                      ) : Center(
                        child: smallText(_vouchersController.noData.value),
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
