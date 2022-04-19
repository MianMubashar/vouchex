import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/authentication/phone_controller.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class MobileNumber extends StatelessWidget {
    MobileNumber({Key? key}) : super(key: key);

    final PhoneController _controller = Get.find();
    final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _controller.isLoading.value,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(image: AssetImage('assets/images/bg_img.png'), fit: BoxFit.fill, opacity: 0.5)
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36)
                        )
                    ),
                    height: MediaQuery.of(context).size.height/1.8,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 30),
                          child: titleText("Create Account"),
                        ),
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16, top: 30),
                                child: smallText("Email"),
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: VoucherFields(
                                  hintText: "Enter Email",
                                  textEditingController: _controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String? value) => value!.isEmpty
                                      ? "Required"
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, top: 10),
                                child: smallText("Password"),
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: VoucherFields(
                                  hintText: "Enter Password",
                                  textEditingController: _controller.passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  validator: (String? value) => value!.isEmpty
                                      ? "Required"
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),

                       /* Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: IntlPhoneField(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: secondaryColor,
                              hintText: "Phone Number",
                              hintStyle: TextStyle(color: Color(0XFF464646), fontSize: 16, fontFamily: 'Nunito'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: secondaryColor, width: 0.5)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: secondaryColor, width: 0.5)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: secondaryColor, width: 0.5)
                              ),
                            ),
                            initialCountryCode: 'PK',
                            flagsButtonPadding: const EdgeInsets.only(left: 10),
                            dropdownIcon: const Icon(Icons.arrow_drop_down, color: primaryColor,),
                            cursorColor: primaryColor,
                            dropdownIconPosition: IconPosition.trailing,
                            onChanged: (phone) {
                              _controller.phoneNumber.value = phone.completeNumber.toString();
                              _controller.countryCode.value = phone.countryCode.toString();

                            },
                          ),
                        ),*/
                        const SizedBox(height: 25,),
                        RoundedRectangleButton(
                          onPress: () async{
                            if(_formKey.currentState!.validate()) {
                              if(_controller.emailController.text.isEmail) {
                                await _controller.register();
                              } else {
                                Get.snackbar('Error', 'The email must be a valid email address');
                              }
                            }
                          },
                          title: 'Register',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
      )
    );
  }
}
