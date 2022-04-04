import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class VoucherCard extends StatelessWidget {
    const VoucherCard({
     Key? key,
     required this.model,
   }) : super(key: key);

  final AllVouchersData model;
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
                  CachedNetworkImage(
                    imageUrl: "https://vouchex.reverbsoft.com/public/${model.coverPhotoPath}",
                    placeholder: (context, url) => const SpinKitPulse(color: primaryColor,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 30),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      foregroundImage: NetworkImage("https://vouchex.reverbsoft.com/public/${model.profilePhotoPath}"),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: Align(
                        alignment: Alignment.centerLeft,
                          child: titleText(model.name!, size: 18)),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                          child: titleText(model.code!, size: 18),
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
                      profileImage: "https://vouchex.reverbsoft.com/public/${model.profilePhotoPath}",
                      bgImage: "https://vouchex.reverbsoft.com/public/${model.coverPhotoPath}",
                      vTitle: model.name!,
                      code: model.code!,
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
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

class PendingRequestCard extends StatelessWidget {
  const PendingRequestCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PEData model;
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
                  CachedNetworkImage(
                    imageUrl: "https://vouchex.reverbsoft.com/public/${model.requesterVoucher!.coverPhotoPath}",
                    placeholder: (context, url) => const SpinKitPulse(color: primaryColor,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 30),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      foregroundImage: NetworkImage("https://vouchex.reverbsoft.com/public/${model.requesterVoucher!.profilePhotoPath}"),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: titleText(model.requesterVoucher!.name!, size: 18)),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: titleText(model.requesterVoucher!.code!, size: 18),
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
                      profileImage: "https://vouchex.reverbsoft.com/public/${model.requesterVoucher!.profilePhotoPath}",
                      bgImage: "https://vouchex.reverbsoft.com/public/${model.requesterVoucher!.coverPhotoPath}",
                      vTitle: model.requesterVoucher!.name!,
                      code: model.requesterVoucher!.code!,
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
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
