import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

   final SearchController _controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Search",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left:24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleText("Search For", clr: blackText, size: 20),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Obx(() =>
                          SizedBox(
                              width: 109,
                              height: 40,
                              child: Container(
                                height: 40,
                                width: 109,
                                decoration: BoxDecoration(
                                    color: _controller.business.value == true ? primaryColor : detailsButtonColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    _controller.business.toggle();
                                    _controller.selectedValue.value = 'Business';
                                    _controller.voucher.value = false;
                                  },
                                  child: Text(
                                    'Business',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: _controller.business.value == true ? whiteText : blackText, fontFamily: 'Nunito'),
                                  ),
                                ),
                              )
                          ),
                      ),
                      const SizedBox(width: 10,),
                      smallText('OR', clr: const Color(0XFF7D7D7D), size: 12),
                      const SizedBox(width: 10,),
                      Obx(() =>
                          SizedBox(
                              width: 109,
                              height: 40,
                              child: Container(
                                height: 40,
                                width: 109,
                                decoration: BoxDecoration(
                                    color: _controller.voucher.value == true ? primaryColor : detailsButtonColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    _controller.voucher.toggle();
                                    _controller.selectedValue.value = 'Voucher';
                                    _controller.business.value = false;
                                  },
                                  child: Text(
                                    'Voucher',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: _controller.voucher.value == true ? whiteText : blackText, fontFamily: 'Nunito'),
                                  ),
                                ),
                              )
                          ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  titleText("Business Types", clr: blackText, size: 20),
                  const SizedBox(height: 16,),
                  CustomCheckBoxGroup(
                    buttonTextStyle: const ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: blackText,
                      textStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal
                      ),
                    ),
                    unSelectedColor: detailsButtonColor,
                    unSelectedBorderColor: detailsButtonColor,
                    selectedBorderColor: primaryColor,
                    buttonLables: const [
                      "IT Business",
                      "Restaurants",
                      "Dress",
                      "Food"
                    ],
                    buttonValuesList: const [
                      "IT Business",
                      "Restaurants",
                      "Dress",
                      "Food"
                    ],
                    checkBoxButtonValues: (values) {
                      _controller.selectedBusinessType = values;
                      print(_controller.selectedBusinessType);
                    },
                    spacing: 0,
                    horizontal: false,
                    enableButtonWrap: true,
                    absoluteZeroSpacing: false,
                    selectedColor: primaryColor,
                    padding: 0,
                    enableShape: true,
                    radius: 20,
                    height: 24,
                  )
                ],
              ),
            ),
            const SizedBox(height: 50,),
            RoundedRectangleButton(
              onPress: (){
                var  data = {
                  "businessTypeList" : _controller.selectedBusinessType,
                  "searchResult" : _controller.selectedValue.value,
                };
                Get.toNamed('/SearchResults', arguments: data);
              },
              title: 'Apply',
            )
          ],
        ),
      ),
    );
  }
}
