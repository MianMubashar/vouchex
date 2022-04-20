import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import '../../../../data/model/voucher/my_swapped_vouchers_model.dart';

class VoucherHistoryCard extends StatelessWidget {
  const VoucherHistoryCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final MyVouchersData model;
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
                    imageUrl: "$networkImageBaseUrl${model.business!.coverPhotoPath}",
                    placeholder: (context, url) => const SpinKitPulse(color: primaryColor, size: 25,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),

                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      foregroundImage: NetworkImage("$networkImageBaseUrl${model.business!.coverPhotoPath}"),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
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
                    child: titleText(model.code != null ?"#"+model.code!:"", size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class SwappedVoucherCard extends StatelessWidget {
   SwappedVoucherCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  var loginDetails = GetStorage();

  final SwappedVouchersList model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        AppDialog(
            exchangeRequestId: model.id!,
            requesteeVoucherName: model.requesteeVoucher!.name ?? '',
            requesteeVoucherCode: model.requesteeVoucher!.code ?? '',
            requesteeProfileImage:"$networkImageBaseUrl${loginDetails.read("profile")}",
            requesteeCoverImage: "$networkImageBaseUrl${loginDetails.read("cover")}",
            requesterVoucherName: model.requesterVoucher!.name!,
            requesterVoucherCode: model.requesterVoucher!.code!,
            requesterProfileImage:"$networkImageBaseUrl${model.requestee!.business!.profilePhotoPath}",
            requesterCoverImage: "$networkImageBaseUrl${model.requestee!.business!.coverPhotoPath}",
            requesterTerms: model.requesterVoucher!.termsConditions!,
            showOkButton: false,
            showCancelButton: true,
            isRequesterOrRequestee: 'requestee'
            // cancelPressed: (){
            //   _exchangeRequestController.updateRequestStatus(
            //       model.id!,
            //       "decline"
            //   );
            // },
            // oKPressed: (){
            //   _exchangeRequestController.updateRequestStatus(
            //       model.id!,
            //       "accept"
            //   );
            // },

        ).show(context);
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
                      imageUrl: model.requestee!.business != null ? "$networkImageBaseUrl${model.requestee!.business!.coverPhotoPath}" : "$networkImageBaseUrl${model.coverPhotoPath}",
                      placeholder: (context, url) => const SpinKitPulse(color: primaryColor, size: 25,),
                      errorWidget: (context, url, error) => const Icon(Icons.error),

                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                        foregroundImage: model.requestee!.business != null ? NetworkImage("$networkImageBaseUrl${model.requestee!.profilePhotoPath}") : NetworkImage("$networkImageBaseUrl${model.profilePhotoPath}"),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 50),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: titleText(model.requesteeVoucher!.name != null ? model.requesteeVoucher!.name! : '', size: 18)),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: titleText(model.requesteeVoucher!.code != null ?"#"+model.requesteeVoucher!.code!:"", size: 18),
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
