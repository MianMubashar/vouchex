import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/modules/home/widgets/business_card.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';


class SearchResult extends StatelessWidget {
   SearchResult({Key? key}) : super(key: key);

   final SearchResultController _searchResultController = Get.find();

   String searchResult = Get.arguments['searchResult'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() =>
            ModalProgress(
              call: _searchResultController.isLoading.value,
              child: Column(
                children: [
                  CustomAppBar(
                    title: "Search Results",
                    showLeadingIcon: true,
                    leadingIconPressed: () {Get.back();} ,
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left:15, right: 15),
                    child: RoundedInputField(
                      textEditingController: _searchResultController.search,
                      hintText: "Search Businesses",
                      icon: Icons.search,
                      fillColor: Colors.white,
                      onChanged: (text) {
                        _searchResultController.searchText.value = text.toString();
                      },
                      onSubmitted: (_) {
                        _searchResultController.searchBusinessOrVoucher(isRefresh: true);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  const SizedBox(height: 15,),
                  /*Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width/1.5,
                          child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(width: 5,);
                            },
                            shrinkWrap: true,
                            itemCount: list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Chip(
                                backgroundColor: primaryColor,
                                label: smallText(list[index], size: 12, clr: whiteText),
                                deleteIcon: const Icon(Icons.clear, color: whiteText, size: 12,),
                                onDeleted: (){
                                },
                              );
                            },
                          ),
                        ),
                        smallText(searchResult == 'Business' ? '${businessList.length} Business found' : '${voucherList.length} Vouchers found', size: 12, clr: const Color(0XFF666666))
                      ],
                    ),
                  ),*/
                  const SizedBox(height: 15,),
                  searchResult == 'Business' ? Expanded(
                    child: SmartRefresher(
                      controller: _searchResultController.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await _searchResultController.searchBusinessOrVoucher(isRefresh: true);
                        if (result) {
                          _searchResultController.refreshController.refreshCompleted();
                        } else {
                          _searchResultController.refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await _searchResultController.searchBusinessOrVoucher();
                        if (result) {
                          _searchResultController.refreshController.loadComplete();
                        }
                      },
                      child: ListView.builder(
                        itemCount: _searchResultController.businessesList.length,
                        itemBuilder: (context, index) {
                          return BusinessCard(businessModel: _searchResultController.businessesList[index],);
                        },
                      ),
                    ),
                  ) :
                  Expanded(
                    child: SmartRefresher
                      (controller: _searchResultController.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await _searchResultController.searchBusinessOrVoucher(isRefresh: true);
                        if (result) {
                          _searchResultController.refreshController.refreshCompleted();
                        } else {
                          _searchResultController.refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await _searchResultController.searchBusinessOrVoucher();
                        if (result) {
                          _searchResultController.refreshController.loadComplete();
                        }
                      },
                      child: ListView.builder(
                        itemCount: _searchResultController.vouchersList.length,
                        itemBuilder: (context, index) {
                          return VoucherCard(model: _searchResultController.vouchersList[index],);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
        )
      ),
    );
  }
}
