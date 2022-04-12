import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:get/get.dart';

class EditBusiness extends StatelessWidget {
   EditBusiness({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final EditBusinessController _businessController = Get.find();
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
                        title: "Edit Your Business Page",
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
                              CachedNetworkImage(
                                imageUrl: _businessController.coverFromServer.value,
                                placeholder: (context, url) => const SpinKitPulse(color: primaryColor, size: 25,),
                                fit: BoxFit.cover,
                              ):
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
                                      child: CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.blue,
                                          backgroundImage: NetworkImage(_businessController.profileFromServer.value)
                                      )
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
                                child: smallText('Name', size: 18),
                              ),
                              VoucherFields(
                                textEditingController: _businessController.name,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: smallText('Email', size: 18),
                              ),
                              VoucherFields(
                                textEditingController: _businessController.email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 10,),
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
                                  hint: Text(_businessController.selectedBusiness.value),
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
                                initialCountryCode: 'US',
                                initialValue: _businessController.phoneNumber.value,
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
                                flagsButtonPadding: const EdgeInsets.only(left: 10),
                                dropdownIcon: const Icon(Icons.arrow_drop_down, color: primaryColor,),
                                cursorColor: primaryColor,
                                dropdownIconPosition: IconPosition.trailing,
                                onChanged: (phone) {
                                  _businessController.phoneNumber.value = phone.number;
                                  _businessController.countryCode.value = phone.countryISOCode;
                                  print(_businessController.countryCode.value);
                                },
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: smallText('Description', size: 18),
                              ),
                              VoucherFields(
                                textEditingController: _businessController.description,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                maxLine: 3,
                              ),
                              const SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ),
                      RoundedRectangleButton(
                        onPress: (){
                          _businessController.registerAsBusiness();
                        },
                        title: 'Edit Business',
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
