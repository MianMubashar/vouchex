import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/stripe/stripe_controller.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class VoucherCard extends StatelessWidget {
  final bool vx;
    VoucherCard({
     Key? key,
     required this.model,
     required this.vx
   }) : super(key: key);

  final VoucherModel model;
  final StripeController _stripeController = Get.put(StripeController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Get.toNamed('/VoucherDetails');},
      child: Container(
        decoration:  BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 20,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/voucher_card.png",),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 9),
                    child: Image.asset(model.backgroundImage,),
                  ),
                  /*CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    foregroundImage: AssetImage(model.circleImage),
                  )*/
                  Padding(
                    padding: const EdgeInsets.only(top: 35,left: 20),
                    child: Image.asset(model.circleImage, width: 80, height: 80,),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: model.subtitle != null ? const EdgeInsets.only(left: 20, top: 30) : const EdgeInsets.only(left: 20, top: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                          child: titleText(model.title, size: 18)),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 100),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: cardText(model.subtitle ?? "",)),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                          child: vx == false ? titleText(model.number, size: 18) : titleText("${model.number}usd", size: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              vx == false ?
              DetailsButton(
                title: "Details",
                onPress: (){
                  AppDialog(title: 'Adidas want to exchange voucher with design services. '
                      'we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.',
                      profileImage: model.circleImage,
                      bgImage: model.backgroundImage,
                      vTitle: model.title,
                      subtitle: model.subtitle,
                      code: model.number,
                      cancelPressed: (){
                        Get.back();
                        Get.snackbar("Decline", "You have decline exchange request", colorText: primaryColor, icon: const Icon(Icons.cancel, color: primaryColor,),backgroundColor: Colors.white);
                    },
                      oKPressed: (){
                        Get.back();
                        Get.snackbar("Accepted", "You accepted exchange request", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white);
                  }
                  ).show(context);
                },
              ) :
                  RoundedRectangleButton(
                    onPress: () async  {
                      await _stripeController.makePayment(model.number);
                    },
                    title: 'Buy Now',
                  ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
