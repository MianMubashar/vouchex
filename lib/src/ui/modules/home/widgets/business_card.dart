import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/model/business/business_model.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';


class BusinessCard extends StatelessWidget {
  const BusinessCard({Key? key, required this.businessModel}) : super(key: key);

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
            "businessType" : businessModel.businessTypeId.toString(),
            "number": businessModel.phoneNo,
            "description" : businessModel.description,
            "circleImage": businessModel.profilePhotoPath,
            "coverPhoto" : businessModel.coverPhotoPath
          };
          Get.toNamed('/BusinessDetails', arguments: businessData);
          //Get.toNamed('/BusinessDetails',);
        },
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
            //Image.asset(businessModel.coverPhotoPath),
            CachedNetworkImage(
              imageUrl: businessModel.coverPhotoPath,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35,left: 10),
              child: CachedNetworkImage(
                width: 80,
                height: 80,
                imageUrl: businessModel.profilePhotoPath,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 35),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: titleText(businessModel.name, size: 18)),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 100),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: cardText(businessModel.description,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
