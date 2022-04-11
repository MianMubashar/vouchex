import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class CreateNewVoucher extends StatelessWidget {
   CreateNewVoucher({Key? key}) : super(key: key);

   final CreateVoucherController _createVoucherController = Get.find();
   final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() =>
            ModalProgress(
              call: _createVoucherController.isLoading.value,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: _createVoucherController.voucherId.value == 0 ? 'Create your voucher' : 'Update Voucher',
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
                              validator: (String? value) => value!.isEmpty
                                  ? "Voucher name must be filled"
                                  : null,
                            ),
                            const SizedBox(height: 15,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: smallText('Voucher Code', size: 18),
                            ),
                            VoucherFields(
                              readOnly: _createVoucherController.voucherId.value == 0 ? false : true,
                              textEditingController: _createVoucherController.vCode,
                              height: 50,
                              keyboardType: TextInputType.text,
                              validator: (String? value) => value!.length < 6
                                  ? "Code must be of at least 6 characters"
                                  : null,
                            ),
                            const SizedBox(height: 15,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: smallText('Select Services', size: 18),
                            ),
                            SizedBox(
                              height: 60,
                              child: FormBuilderDropdown<Service>(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(color: secondaryColor, width: 1)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(color: secondaryColor, width: 1)
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(color: secondaryColor, width: 1)
                                  ),
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,),
                                autofocus: true,
                                onChanged: (Service? newValue) {
                                  _createVoucherController.selectedService.value = newValue!.title;
                                  _createVoucherController.selectedServiceId = newValue.id;
                                  print(newValue);
                                  if(_createVoucherController.selectedServicesList.length <= 6) {
                                    _createVoucherController.selectedServicesList.add(newValue.title);
                                    _createVoucherController.selectedServicesListId.add(newValue.id);
                                  }
                                },
                                name: 'services',
                                hint: const Text('Select'),
                                items: _createVoucherController.getServicesList.map<DropdownMenuItem<Service>>((Service value) {
                                  return DropdownMenuItem<Service>(
                                    value: value,
                                    child: Text(value.title),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: smallText(_createVoucherController.selectedServicesList.isNotEmpty ? "Note: you are able to Select 7 services " : " ", size: 12),
                            ),
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
                                      label: smallText(_createVoucherController.selectedServicesList[index].toString(), size: 12, clr: blackText),
                                      deleteIcon: const Icon(Icons.clear, color: blackText, size: 12,),
                                      onDeleted: (){
                                        _createVoucherController.selectedServicesList.removeWhere((element) => element == _createVoucherController.selectedServicesList[index]);
                                        _createVoucherController.selectedServicesListId.removeWhere((element) => element == _createVoucherController.selectedServicesListId[index]);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ) : Container(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                        value: 0,
                                        activeColor: Colors.black,
                                        contentPadding: EdgeInsets.zero,
                                        onChanged: (value) {
                                          _createVoucherController.groupValue.value = value as int;
                                          _createVoucherController.selectedGroupValue.value = true;
                                        },
                                        groupValue: _createVoucherController.groupValue.value,
                                        title: smallText('Keep Static', size: 12, clr: blackText),
                                      ),
                                  ),
                                  Expanded(
                                      child: RadioListTile(
                                        value: 1,
                                        activeColor: Colors.black,
                                        contentPadding: EdgeInsets.zero,
                                        onChanged: (value) {
                                          _createVoucherController.groupValue.value = value as int;
                                          _createVoucherController.selectedGroupValue.value = false;
                                        },
                                        groupValue: _createVoucherController.groupValue.value,
                                        title: smallText('Ends', size: 12, clr: blackText),
                                      ),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      value: 0,
                                      activeColor: Colors.black,
                                      contentPadding: EdgeInsets.zero,
                                      onChanged: (value) {
                                        _createVoucherController.vType.value = value as int;
                                        _createVoucherController.selectedVType.value = true;
                                      },
                                      groupValue: _createVoucherController.vType.value,
                                      title: smallText('Free', size: 12, clr: blackText),
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      value: 1,
                                      activeColor: Colors.black,
                                      contentPadding: EdgeInsets.zero,
                                      onChanged: (value) {
                                        _createVoucherController.vType.value = value as int;
                                        _createVoucherController.selectedVType.value = false;
                                      },
                                      groupValue: _createVoucherController.vType.value,
                                      title: smallText('Not Free', size: 12, clr: blackText),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                      onPress: () async {
                        if(_formKey.currentState!.validate()) {
                          _createVoucherController.voucherId.value == 0 ?
                           await _createVoucherController.createVoucher() :
                              await _createVoucherController.updateVoucher();
                        }
                        },
                      title: _createVoucherController.voucherId.value == 0 ? 'Create Voucher' : 'Update Voucher',
                      titleColor: whiteText,
                      buttonColor: blackText,
                      showIcon: false,
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
        )
      ),
    );
  }
}
