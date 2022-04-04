import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

   final SearchController _controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() =>
            ModalProgress(
              call: _controller.isLoading.value,
              child: Column(
                children: [
                  const CustomAppBar(
                    title: "Search",
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
                            const SizedBox(width: 10,),
                            smallText('OR', clr: const Color(0XFF7D7D7D), size: 12),
                            const SizedBox(width: 10,),
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
                          ],
                        ),
                        const SizedBox(height: 16,),
                        _controller.selectedValue.value == 'Business' ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              buttonLables: _controller.getBusinessTypeList.map((e) => e.name).toList(),
                              buttonValuesList: _controller.getBusinessTypeList.map((e) => e.id).toList(),
                              checkBoxButtonValues: (values) {
                                _controller.selectedBusinessType.value = values;
                                print("Business List : ${_controller.selectedBusinessType.toList()}");
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
                              width: 150,
                            ),
                          ],
                        ) : const SizedBox(width: 0, height: 0,),
                        //const SizedBox(height: 16,),
                        _controller.selectedValue.value == 'Voucher' ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleText("Services", clr: blackText, size: 20),
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
                              buttonLables: _controller.getServicesList.map((e) => e.title).toList(),
                              buttonValuesList: _controller.getServicesList.map((e) => e.id).toList(),
                              checkBoxButtonValues: (values) {
                                _controller.selectedServicesList.value = values;
                                print("Service List : ${_controller.selectedServicesList.toList()}");
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
                              width: 150,
                            )
                          ],
                        ) : const SizedBox(width: 0,height: 0,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,),
                  RoundedRectangleButton(
                    onPress: (){
                      var  data = {
                      "servicesList" : _controller.selectedServicesList,
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
        )
      ),
    );
  }
}
