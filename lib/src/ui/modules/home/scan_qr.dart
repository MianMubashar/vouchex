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
      body: SafeArea(
        child: Container(
          color: qrBackgroundColor,
          child: Column(
            children: [
              CustomAppBar(
                title: "Scan QR code",
                showLeadingIcon: true,
                leadingIconPressed: () {Get.back();} ,
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
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        height: 40,
                        child: Obx(() =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: smallText(_qrController.code.value),
                            ),
                        )
                      )
                    ),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/4,
                      child: SmallButton(
                        onPress: () {
                          ImageDialog(
                            imageUrl: 'assets/images/congrats_img.png',
                            title: 'Congratulations\nYou Get 10% discount'
                          ).show(context);
                        },
                        title: 'Redeem',
                        fontSize: 20,
                        height: 40,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
