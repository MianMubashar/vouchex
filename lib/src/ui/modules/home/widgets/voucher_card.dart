import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      onTap: (){
        var voucherData = {
          "qrImage" : "assets/images/qr_code.png",
          "businessName" : model.business!.name ?? '',
          "expiryDate" : DateFormat("dd/MM/yyyy").format(model.expiry!),
          "terms" : model.termsConditions,
          "services" : model.service,
          "marketValue" : model.marketValue ?? '',
          "tokenCode" : model.code ?? '',
          "isFree" : model.isFree
        };
        Get.toNamed('/VoucherDetails', arguments: voucherData);
      },
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
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  ),
                    child: CachedNetworkImage(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      imageUrl: model.coverPhotoPath == '0' && model.business != null
                          ? '$networkImageBaseUrl${model.business!.coverPhotoPath}':
                      '$networkImageBaseUrl${model.coverPhotoPath}',
                      placeholder: (context, url) => const SpinKitPulse(color: primaryColor,),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    foregroundImage: NetworkImage(model.profilePhotoPath == '0' && model.business != null
                        ?'$networkImageBaseUrl${model.business!.profilePhotoPath}':
                    '$networkImageBaseUrl${model.profilePhotoPath}'),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 45),
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
                        child: titleText("#"+model.code!, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 10,),
            // DetailsButton(
            //   title: "Details",
            //   onPress: (){
            //     AppDialog(title: 'Adidas want to exchange voucher with design services. '
            //         'we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.',
            //         profileImage: "https://vouchex.reverbsoft.com/public/${model.profilePhotoPath}",
            //         bgImage: "https://vouchex.reverbsoft.com/public/${model.coverPhotoPath}",
            //         vTitle: model.name!,
            //         code: model.code!,
            //         cancelPressed: (){
            //           Get.back();
            //           Get.snackbar("Decline", "You have decline exchange request", colorText: primaryColor, icon: const Icon(Icons.cancel, color: primaryColor,),backgroundColor: Colors.white);
            //       },
            //         oKPressed: (){
            //           Get.back();
            //           Get.snackbar("Accepted", "You accepted exchange request", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white);
            //     }
            //     ).show(context);
            //   },
            // ),
            const SizedBox(height: 20,),
          ],
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
                    imageUrl: "$networkImageBaseUrl${model.requesterVoucher!.coverPhotoPath}",
                    placeholder: (context, url) => const SpinKitPulse(color: primaryColor,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 30),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      foregroundImage: NetworkImage("$networkImageBaseUrl${model.requesterVoucher!.profilePhotoPath}"),
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
                        child: titleText("#"+model.requesterVoucher!.code!, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              DetailsButton(
                title: "Details",
                onPress: (){
                  AppDialog(title:model.requesterVoucher?.termsConditions ?? '',
                  //'we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.',
                      profileImage: "$networkImageBaseUrl${model.requesterVoucher!.profilePhotoPath}",
                      bgImage: "$networkImageBaseUrl${model.requesterVoucher!.coverPhotoPath}",
                      vTitle: model.requesterVoucher!.name!,
                      code: "#"+model.requesterVoucher!.code!,
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

