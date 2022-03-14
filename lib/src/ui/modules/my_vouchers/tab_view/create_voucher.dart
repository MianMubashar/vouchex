import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';


class CreateVoucher extends StatelessWidget {
  const CreateVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset("assets/images/blank_voucher_img.png", width: MediaQuery.of(context).size.width,),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){Get.toNamed('/CreateNewVoucher');},
                      child: titleText("Tap to Create a Voucher", size: 20, clr: primaryColor),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
