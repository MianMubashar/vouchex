import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/authentication/login_controller.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   final LoginController _loginController = Get.find();
   final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() =>
            SafeArea(
              child: ModalProgress(
                call: _loginController.isLoading.value,
                child: Container(
                  color: secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(36))
                        ),
                        height: MediaQuery.of(context).size.height/1.9,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24, top: 30),
                              child: titleText("Login"),
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
                                      textEditingController: _loginController.emailController,
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
                                      textEditingController: _loginController.passwordController,
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
                            const SizedBox(height: 25,),
                            RoundedRectangleButton(
                              onPress: () async{
                                if(_formKey.currentState!.validate()) {
                                  if(_loginController.emailController.text.isEmail) {
                                    await _loginController.loginRequest();
                                  } else {
                                    Get.snackbar('Error', 'The email must be a valid email address');
                                  }
                                }
                              },
                              title: 'Get Started',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        )
    );
  }
}
