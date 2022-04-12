import 'package:flutter/material.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ScanQRScreen extends StatelessWidget {
   ScanQRScreen({Key? key}) : super(key: key);

   final QrController _qrController = Get.put(QrController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          ModalProgress(
            call: _qrController.isLoading.value,
            child: SafeArea(
              child: Container(
                color: qrBackgroundColor,
                child: Column(
                  children: [
                    const CustomAppBar(
                      title: "Scan QR code",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Container(
                        color: const Color.fromRGBO(196, 196, 196, 0.08),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30, top: 16),
                              child: titleText("TO use voucher please scan QR code ", clr: Colors.white, textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/2,
                              child: QRView(
                                key: _qrController.qrKey,
                                onQRViewCreated: _qrController.onQRViewCreated,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: /*Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                ),
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: smallText(_qrController.code.value),
                                ),
                              )*/
                            TextField(
                              controller: _qrController.qrResult,
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 4),
                                  hintText: "Token",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border:  OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(color: secondaryColor, width: 1)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(color: secondaryColor, width: 1)
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(color: secondaryColor, width: 1)
                                  ),
                                  labelStyle:TextStyle(fontSize: 16, color: greyText, fontFamily: 'Nunito'),
                                  hintStyle: TextStyle(fontSize: 16, color: greyText, fontFamily: 'Nunito')
                              ),
                            )
                          ),
                          const SizedBox(width: 10,),
                          SmallButton(
                            onPress: () {
                              if(_qrController.qrResult.text.isNotEmpty) {
                                _qrController.redeemVoucher();
                              }
                            },
                            title: 'Redeem',
                            fontSize: 20,
                            height: 40,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      )
    );
  }
}
