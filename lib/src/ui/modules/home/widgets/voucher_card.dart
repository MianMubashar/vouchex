import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/controllers/controllers.dart';
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
          "services" : model.service ?? [],
          "marketValue" : model.marketValue ?? '',
          "tokenCode" : model.uuId ?? '',
          "isFree" : model.isFree,
          'userId':model.userId,
          'voucherId': model.id,
          'fromWhere' : 'vouchers'
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
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class PendingRequestCard extends StatelessWidget {
   PendingRequestCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PEData model;
  final PendingExchangeRequestController _exchangeRequestController = Get.put(PendingExchangeRequestController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        var voucherData = {
          "qrImage" : "assets/images/qr_code.png",
          "businessName" : 'Adidas',
          "expiryDate" : DateFormat("dd/MM/yyyy").format(model.requesterVoucher!.expiry!),
          "terms" : model.requesterVoucher!.termsConditions,
          "services" : [],
          "marketValue" : model.requesterVoucher!.marketValue,
          "tokenCode" : '',
          "isFree" : 0,
          'userId': 0,
          'voucherId': model.id,
          'fromWhere' : 'pendingRequest'
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
                  model.requesterVoucher!.code == null ? Container(): Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: titleText("#"+model.requesterVoucher!.code! , size: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              DetailsButton(
                title: "Details",
                onPress: (){
                  AppDialog(
                    exchangeRequestId: model.id!,
                    requesteeVoucherName: model.requesteeVoucher!.name!,
                    requesteeVoucherCode: model.requesteeVoucher!.code!,
                    requesteeProfileImage:"$networkImageBaseUrl${model.requesteeVoucher!.profilePhotoPath}",
                    requesteeCoverImage: "$networkImageBaseUrl${model.requesteeVoucher!.coverPhotoPath}",
                    requesterVoucherName: model.requesterVoucher!.name!,
                    requesterVoucherCode: model.requesterVoucher!.code!,
                    requesterProfileImage:"$networkImageBaseUrl${model.requesterVoucher!.profilePhotoPath}",
                    requesterCoverImage: "$networkImageBaseUrl${model.requesterVoucher!.coverPhotoPath}",
                    requesterTerms: model.requesterVoucher!.termsConditions!,
                      cancelPressed: (){
                        _exchangeRequestController.updateRequestStatus(
                          model.id!,
                          "decline"
                        );
                      },
                      oKPressed: (){
                        _exchangeRequestController.updateRequestStatus(
                            model.id!,
                            "accept"
                        );
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

