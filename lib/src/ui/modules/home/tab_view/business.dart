import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/businesses/get_businesses.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../widgets/business_card.dart';
import 'package:get/get.dart';


class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key}) : super(key: key);

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
                  Padding(
                    padding: const EdgeInsets.only(left:15, right: 15),
                    child: RoundedInputField(
                      textEditingController: search,
                      hintText: "Search Businesses",
                      icon: Icons.search,
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Expanded(
                    child: SmartRefresher(
                      controller: _businessesController.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await _businessesController.getBusinessesData(isRefresh: true);
                        if (result) {
                          _businessesController.refreshController.refreshCompleted();
                        } else {
                          _businessesController.refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await _businessesController.getBusinessesData();
                        if (result) {
                          _businessesController.refreshController.loadComplete();
                        } else {
                          _businessesController.refreshController.loadFailed();
                        }
                      },
                      child: ListView.builder(
                        itemCount: _businessesController.businessesList.length,
                        itemBuilder: (context, index) {
                          return BusinessCard(businessModel: _businessesController.businessesList[index]);
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
