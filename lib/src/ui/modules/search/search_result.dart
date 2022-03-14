
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/home/widgets/business_card.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';


class SearchResult extends StatelessWidget {
   SearchResult({Key? key}) : super(key: key);

   final TextEditingController _search = TextEditingController();
   List list = Get.arguments['businessTypeList'];
   String searchResult = Get.arguments['searchResult'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                textEditingController: _search,
                hintText: "Search Businesses",
                icon: Icons.search,
                fillColor: Colors.white,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
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
            ),
            const SizedBox(height: 15,),
            searchResult == 'Business' ? Expanded(
              child: ListView.builder(
                itemCount: businessList.length,
                itemBuilder: (context, index) {
                  return BusinessCard(businessModel: businessList[index]);
                },
              ),
            ) :
            Expanded(
              child: ListView.builder(
                itemCount: voucherList.length,
                itemBuilder: (context, index) {
                  return VoucherCard(model: voucherList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
