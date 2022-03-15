import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vouchex/src/controllers/authentication/phone_controller.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class MobileNumber extends StatelessWidget {
    MobileNumber({Key? key}) : super(key: key);

    final PhoneController _controller = Get.find();
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
                    height: MediaQuery.of(context).size.height/2.2,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 30),
                          child: titleText("Get going with VExchange"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 30),
                          child: smallText("Enter Phone Number"),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
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

                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        RoundedRectangleButton(
                          onPress: () async{
                            print(_controller.phoneNumber.value);
                            await _controller.login();
                          },
                          title: 'Get Started',
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
