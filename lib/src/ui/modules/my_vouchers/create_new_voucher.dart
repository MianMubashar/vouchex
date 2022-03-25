
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class CreateNewVoucher extends StatelessWidget {
   CreateNewVoucher({Key? key}) : super(key: key);

   final CreateVoucherController _createVoucherController = Get.find();
   final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Create your voucher",
                showLeadingIcon: true,
                leadingIconPressed: () {Get.back();} ,
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText('Create your voucher', size: 20, clr: Colors.black),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: smallText('Voucher Name', size: 18),
                      ),
                      VoucherFields(
                        textEditingController: _createVoucherController.vName,
                        height: 50,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: smallText('Voucher Code', size: 18),
                      ),
                      VoucherFields(
                        textEditingController: _createVoucherController.vCode,
                        height: 50,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: smallText('Select Services', size: 18),
                      ),
                      DropDownButton(
                        list: _createVoucherController.services,
                        borderColor: const Color.fromRGBO(0, 0, 0, 0.1),
                        name: 'services',
                        onChanged: (value) {
                          _createVoucherController.selectedService.value = value!;
                          if(_createVoucherController.selectedServicesList.length <= 6) {
                            _createVoucherController.selectedServicesList.add(value);
                          }
                        },
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: smallText('Voucher Type', size: 18),
                      ),
                      DropDownButton(
                        list: _createVoucherController.vType,
                        borderColor: const Color.fromRGBO(0, 0, 0, 0.1),
                        name: 'type',
                        onChanged: (value) {
                          _createVoucherController.selectedType.value = value!;
                        },
                      ),
                      Obx(() =>
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: smallText(_createVoucherController.selectedServicesList.isNotEmpty ? "Note: you are able to Select 7 services " : " ", size: 12),
                          )
                      ),
                      Obx(() =>
                      _createVoucherController.selectedServicesList.isNotEmpty ?
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(width: 5,);
                                },
                                itemCount: _createVoucherController.selectedServicesList.length,
                                itemBuilder: (context, index) {
                                  return Chip(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                    ),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: detailsButtonColor,
                                    label: smallText(_createVoucherController.selectedServicesList[index], size: 12, clr: blackText),
                                    deleteIcon: const Icon(Icons.clear, color: blackText, size: 12,),
                                    onDeleted: (){
                                      _createVoucherController.selectedServicesList.removeWhere((element) => element == _createVoucherController.selectedServicesList[index]);
                                    },
                                  );
                                },
                              ),
                            ),
                          ) : Container()
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Obx(() =>
                                  RadioListTile(
                                    value: 0,
                                    activeColor: Colors.black,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: (value) {
                                      _createVoucherController.groupValue.value = value as int;
                                    },
                                    groupValue: _createVoucherController.groupValue.value,
                                    title: smallText('Keep Static', size: 12, clr: blackText),
                                  ),
                              )
                            ),
                            Expanded(
                              child: Obx(() =>
                                  RadioListTile(
                                    value: 1,
                                    activeColor: Colors.black,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: (value) {
                                      _createVoucherController.groupValue.value = value as int;
                                    },
                                    groupValue: _createVoucherController.groupValue.value,
                                    title: smallText('Ends', size: 12, clr: blackText),
                                  ),
                              )
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: smallText('Terms and Conditions', size: 18),
                      ),
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          onTap: (){_createVoucherController.selectDate();},
                          tileColor: Colors.white,
                          title: smallText(DateFormat("dd/MM/yy").format(_createVoucherController.selectedDate.value).toString()),
                          trailing: const Icon(Icons.date_range_sharp, color: Colors.black),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12),
                              ),
                              side: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 0.5)
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: smallText('Market Value (\$)', size: 18),
                      ),
                      VoucherFields(
                        textEditingController: _createVoucherController.marketValue,
                        height: 50,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: smallText('Terms and Conditions', size: 18),
                      ),
                      VoucherFields(
                        textEditingController: _createVoucherController.terms,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLine: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              DetailsButton(
                onPress: () {Get.back();},
                title: 'Create Voucher',
                titleColor: whiteText,
                buttonColor: blackText,
                showIcon: false,
              ),
              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
