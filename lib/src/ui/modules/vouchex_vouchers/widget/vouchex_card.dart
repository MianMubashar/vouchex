import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vouchex/src/controllers/stripe/stripe_controller.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class VouchexCard extends StatelessWidget {
  VouchexCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VouchersData model;
  final StripeController _stripeController = Get.put(StripeController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
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
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/voucher_card.png",),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 9),
                  child:
                  CachedNetworkImage(
                    imageUrl: "$networkImageBaseUrl${model.coverPhotoPath}",
                    placeholder: (context, url) => const SpinKitPulse(color: primaryColor, size: 25,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35,left: 20),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    foregroundImage: NetworkImage("$networkImageBaseUrl${model.profilePhotoPath}"),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 50, right: 40),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: titleText(model.name, size: 18)),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: titleText("${model.marketValue}usd", size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            RoundedRectangleButton(
              onPress: () async  {
                var price = model.marketValue.substring(0,2);
                await _stripeController.makePayment(price);
              },
              title: 'Buy Now',
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}