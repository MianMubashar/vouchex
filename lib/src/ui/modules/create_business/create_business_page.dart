import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class CreateBusinessPage extends StatelessWidget {
   CreateBusinessPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final CreateBusinessController _businessController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() =>
            ModalProgress(
              call: _businessController.isLoading.value,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: "Create Your Business Page",
                      showLeadingIcon: true,
                      leadingIconPressed: () {Get.back();} ,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 107,
                          width: MediaQuery.of(context).size.width,
                          color: const Color(0XFFF7F7F7),
                          child: InkWell(
                            onTap: (){_businessController.getCoverImage(ImageSource.gallery);},
                            child: _businessController.selectedCoverImagePath.value == '' ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_circle_outline, color: Colors.black,),
                                const SizedBox(width: 5,),
                                titleText('Update your cover', size: 15)
                              ],
                            ) :
                            Image.file(File(_businessController.selectedCoverImagePath.value), fit: BoxFit.fill,),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 65),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                  onTap: () {_businessController.getProfileImage(ImageSource.gallery);},
                                  child: _businessController.selectedProfileImagePath.value == '' ?
                                  Container(
                                    width: 71,
                                    height: 71,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:const  BorderRadius.all(Radius.circular(35)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 20,
                                          offset: const Offset(2, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.camera_alt_outlined, color: Colors.black, size: 30,),
                                  ) :
                                  CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.blue,
                                      backgroundImage: FileImage(File(_businessController.selectedProfileImagePath.value),)
                                  )
                              )
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          smallText(_businessController.businessName.text.isNotEmpty ? _businessController.businessName.text : "Enter Name", size: 20, clr: Colors.black),
                          IconButton(
                            onPressed: (){
                              Get.defaultDialog(
                                title: '',
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: smallText('Name', size: 18),
                                    ),
                                    VoucherFields(
                                      hintText: "Enter name",
                                      textEditingController: _businessController.businessName,
                                      keyboardType: TextInputType.text,
                                      validator: (String? value) => value!.isEmpty
                                          ? "Required"
                                          : null,
                                    ),
                                    const SizedBox(height: 5,),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: smallText('Email', size: 18),
                                    ),
                                    VoucherFields(
                                      hintText: "Enter Email",
                                      textEditingController: _businessController.businessEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String? value) => value!.isEmpty
                                          ? "Required"
                                          : null,
                                    ),
                                  ],
                                ),
                                textConfirm: 'Add',
                                onConfirm: () {
                                  if(_businessController.businessEmail.text.isEmail) {
                                    Get.back();
                                  } else {
                                    Get.snackbar('Error', 'The email must be a valid email address');
                                  }
                                },
                                buttonColor: primaryColor,
                                confirmTextColor: Colors.white
                              );
                            },
                            icon: const Icon(Icons.edit_outlined, color: primaryColor,),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: smallText(_businessController.businessEmail.text.isNotEmpty ? _businessController.businessEmail.text : "Enter Email"),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(color: const Color(0XFFE1E1E1), height: 0.5,),
                    ),
                    const SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: smallText('Select Business Type', size: 18),
                            ),
                            SizedBox(
                              height: 60,
                              child: FormBuilderDropdown<Business>(
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
                                onChanged: (Business? newValue) {
                                  _businessController.selectedBusiness.value = newValue!.name;
                                  _businessController.selectedBusinessID = newValue.id;
                                  print(newValue);
                                },
                                name: 'business',
                                hint: const Text('Select'),
                                items: _businessController.getBusinessTypeList.map<DropdownMenuItem<Business>>((Business value) {
                                  return DropdownMenuItem<Business>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: smallText('Enter Your Phone Number', size: 18),
                            ),
                            IntlPhoneField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: whiteText,
                                hintText: "Phone Number",
                                hintStyle: TextStyle(color: Color(0XFF464646), fontSize: 16, fontFamily: 'Nunito'),
                                border:  OutlineInputBorder(
                                    borderRadius:  BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1)
                                ),
                                enabledBorder:  OutlineInputBorder(
                                    borderRadius:  BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1)
                                ),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius:  BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1)
                                ),
                              ),
                              initialCountryCode: 'US',
                              flagsButtonPadding: const EdgeInsets.only(left: 10),
                              dropdownIcon: const Icon(Icons.arrow_drop_down, color: primaryColor,),
                              cursorColor: primaryColor,
                              dropdownIconPosition: IconPosition.trailing,
                              onChanged: (phone) {
                                _businessController.phoneNumber.value = phone.number.toString();
                                _businessController.countryCode.value = phone.countryISOCode;
                              },
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: smallText('Description', size: 18),
                            ),
                            VoucherFields(
                              name: 'bDesc',
                              textEditingController: _businessController.description,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLine: 3,
                              validator: (String? value) => value!.isEmpty
                                  ? "Required"
                                  : null,
                            ),
                            const SizedBox(height: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  onTap: (){_businessController.isVoucherFieldsVisible.toggle();},
                                  title: titleText('Want to create Voucher?', size: 20),
                                  trailing: _businessController.isVoucherFieldsVisible.value ? const Icon(Icons.keyboard_arrow_up) : const Icon(Icons.keyboard_arrow_down),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                if(_businessController.isVoucherFieldsVisible.value == true)...[
                                  const SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: smallText('Voucher Name', size: 18),
                                  ),
                                  VoucherFields(
                                    name: 'voucherName',
                                    textEditingController: _businessController.vName,
                                    height: 50,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: smallText('Voucher Code', size: 18),
                                  ),
                                  VoucherFields(
                                    name: 'voucherCode',
                                    textEditingController: _businessController.vCode,
                                    height: 50,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: smallText('Voucher Description', size: 18),
                                  ),
                                  VoucherFields(
                                    name: 'vDescriptions',
                                    textEditingController: _businessController.vDescription,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    maxLine: 3,
                                  ),
                                  const SizedBox(height: 10,),
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
                                        _businessController.selectedService.value = newValue!.title;
                                        _businessController.selectedServiceId = newValue.id;
                                        print(newValue);
                                        if(_businessController.selectedServicesList.length <= 6) {
                                          _businessController.selectedServicesList.add(newValue.title);
                                          _businessController.selectedServicesListId.add(newValue.id);
                                        }
                                      },
                                      name: 'voucherServices',
                                      hint: const Text('Select'),
                                      items: _businessController.getServicesList.map<DropdownMenuItem<Service>>((Service value) {
                                        return DropdownMenuItem<Service>(
                                          value: value,
                                          child: Text(value.title),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: smallText('Voucher Type', size: 18),
                                  ),
                                  DropDownButton(
                                    list: _businessController.vType,
                                    borderColor: const Color.fromRGBO(0, 0, 0, 0.1),
                                    name: 'businessTypes',
                                    onChanged: (value) {
                                      _businessController.selectedType.value = value!;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: smallText(_businessController.selectedServicesList.isNotEmpty ? "Note: you are able to Select 7 services " : " ", size: 12),
                                  ),
                                  _businessController.selectedServicesList.isNotEmpty ?
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
                                        itemCount: _businessController.selectedServicesList.length,
                                        itemBuilder: (context, index) {
                                          return Chip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(7))
                                            ),
                                            padding: EdgeInsets.zero,
                                            backgroundColor: detailsButtonColor,
                                            label: smallText(_businessController.selectedServicesList[index], size: 12, clr: blackText),
                                            deleteIcon: const Icon(Icons.clear, color: blackText, size: 12,),
                                            onDeleted: (){
                                              _businessController.selectedServicesList.removeWhere((element) => element == _businessController.selectedServicesList[index]);
                                              _businessController.selectedServicesListId.removeWhere((element) => element == _businessController.selectedServicesListId[index]);
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
                                              _businessController.groupValue.value = value as int;
                                            },
                                            groupValue: _businessController.groupValue.value,
                                            title: smallText('Keep Static', size: 12, clr: blackText),
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            value: 1,
                                            activeColor: Colors.black,
                                            contentPadding: EdgeInsets.zero,
                                            onChanged: (value) {
                                              _businessController.groupValue.value = value as int;
                                            },
                                            groupValue: _businessController.groupValue.value,
                                            title: smallText('Ends', size: 12, clr: blackText),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: smallText('Expiry Date', size: 18),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: ListTile(
                                      onTap: (){_businessController.selectDate();},
                                      tileColor: Colors.white,
                                      title: smallText(DateFormat("dd/MM/yy").format(_businessController.selectedDate.value).toString()),
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
                                    textEditingController: _businessController.marketValue,
                                    height: 50,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: smallText('Terms and Conditions', size: 18),
                                  ),
                                  VoucherFields(
                                    textEditingController: _businessController.terms,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    maxLine: 3,
                                  ),
                                ]
                              ],
                            ),
                            const SizedBox(height: 25,),
                          ],
                        ),
                      ),
                    ),
                    RoundedRectangleButton(
                      onPress: (){
                        if(_businessController.selectedProfileImagePath.value == '') {
                          Get.snackbar("Empty fields", "Please add profile image");
                        } else if(_businessController.selectedCoverImagePath.value== '') {
                          Get.snackbar("Empty fields", "Please add both cover image");
                        }
                        else if(_businessController.businessName.text.isEmpty ) {
                          Get.snackbar("Empty field", "Please enter name");
                        } else if(_businessController.businessEmail.text.isEmpty) {
                          Get.snackbar("Empty field", "Please enter email");
                        }
                        else if(_businessController.selectedBusinessID == 0) {
                          Get.snackbar("Empty field", "Please select business type");
                        } else if(_businessController.phoneNumber.value == '') {
                          Get.snackbar("Empty fields", "Please enter phone number");
                        } else {
                          if(_formKey.currentState!.validate()) {
                            _businessController.registerAsBusiness();
                          }
                        }
                      },
                      title: 'Create Page',
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
        )
      ),
    );
  }
}
