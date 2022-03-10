import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class VoucherCard extends StatelessWidget {
   const VoucherCard({Key? key, required this.model}) : super(key: key);

  final VoucherModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        child: titleText(model.number, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            DetailsButton(
              title: "Details",
              onPress: (){
                AppDialog(title: 'Adidas want to exchange voucher with design services. '
                    'we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.',
                  cancelPressed: (){Get.back();},
                  oKPressed: (){Get.toNamed('/VoucherDetails');}
                ).show(context);
              },
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
