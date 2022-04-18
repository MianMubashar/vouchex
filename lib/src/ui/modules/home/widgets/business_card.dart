import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/business/business_model.dart';
import 'package:vouchex/src/data/model/voucher/voucher_model.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';


class BusinessCard extends StatelessWidget {
  const BusinessCard({Key? key, required this.businessModel,}) : super(key: key);

  final Datum businessModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: InkWell(
        onTap: (){
          var  businessData = {
            "title" : businessModel.name,
            "email": businessModel.email,
            "businessType" : businessModel.businessType!.name,
            "number": businessModel.phoneNo,
            "description" : businessModel.description,
            "circleImage": "$networkImageBaseUrl${businessModel.profilePhotoPath}",
            "coverPhoto" : "$networkImageBaseUrl${businessModel.coverPhotoPath}",
            "vouchersList" : businessModel.vouchers ?? [],
          };
          Get.toNamed('/BusinessDetails', arguments: businessData);
          //Get.toNamed('/BusinessDetails',);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      offset: const Offset(0, 1), // Shadow position
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 190,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  height: 72,
                  fit: BoxFit.cover,
                  imageUrl: "$networkImageBaseUrl${businessModel.coverPhotoPath}",
                  placeholder: (context, url) => const SpinKitPulse(color: primaryColor,),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45,left: 10),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("$networkImageBaseUrl${businessModel.profilePhotoPath}"),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 35),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: titleText(businessModel.name!, size: 18)),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 100),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: cardText(businessModel.description!,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
