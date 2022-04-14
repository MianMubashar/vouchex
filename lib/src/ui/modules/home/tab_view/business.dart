import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/businesses/get_businesses.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../widgets/business_card.dart';
import 'package:get/get.dart';


class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key,}) : super(key: key);

  final TextEditingController search = TextEditingController();
  final GetBusinessesController _businessesController = Get.put(GetBusinessesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _businessesController.isLoading.value,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  Expanded(
                    child: /*SmartRefresher(
                      controller: _businessesController.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await _businessesController.getBusinessesData(isRefresh: true);
                        if (result) {
                          _businessesController.refreshController.refreshCompleted();
                        }
                      },
                      onLoading: () async {
                        final result = await _businessesController.getBusinessesData();
                        if (result) {
                          _businessesController.refreshController.loadComplete();
                        }
                      },
                      child:  _businessesController.businessesList.isNotEmpty ? ListView.builder(
                        itemCount: _businessesController.businessesList.length,
                        itemBuilder: (context, index) {
                          return BusinessCard(businessModel: _businessesController.businessesList[index]);
                        },
                      ) : Center(
                        child: smallText(_businessesController.noData.value),
                      )
                    ),*/
                    PagedListView<int, Datum>(
                      pagingController: _businessesController.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Datum>(
                          itemBuilder: (context, item, index) => BusinessCard(businessModel: _businessesController.businessesList[index])
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
