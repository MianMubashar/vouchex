import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:get/get.dart';

class MyBusinessDetails extends StatelessWidget {
   MyBusinessDetails({Key? key}) : super(key: key);

  final MyBusinessDetailsController _businessDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Business Details',
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();},
            ),
            FutureBuilder(
              future: _businessDetailsController.validateToken(),
              builder: (ctx, snapshot){
                if(snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 107,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0XFFF7F7F7),
                            child: //Image.asset("assets/images/kfc_bg.png")
                            CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "$networkImageBaseUrl${_businessDetailsController.coverPhoto}",
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 70),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage("$networkImageBaseUrl${_businessDetailsController.profilePhoto}"),
                                )
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, right: 30),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //
                      //     ],
                      //   ),
                      // ),
                      IconButton(
                        onPressed: (){
                          var data = {
                            "name" : _businessDetailsController.name,
                            "email" : _businessDetailsController.email,
                            "phone" : _businessDetailsController.phone,
                            "countryCode" : _businessDetailsController.countryCode,
                            "description" : _businessDetailsController.description,
                            "business_type_id" : _businessDetailsController.businessTypeId,
                            "businessTypeName" : _businessDetailsController.businessTypeName,
                            "business_id" : _businessDetailsController.businessId,
                            "profilePhoto" : "$networkImageBaseUrl${_businessDetailsController.profilePhoto}",
                            "coverPhoto" : "$networkImageBaseUrl${_businessDetailsController.coverPhoto}",
                            "businessTypeList" : _businessDetailsController.getBusinessTypeList,
                          };
                          Get.toNamed('/EditBusiness', arguments: data);
                        },
                        icon: const Icon(Icons.edit, color: primaryColor,),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: smallText(_businessDetailsController.name, size: 20, clr: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: smallText(_businessDetailsController.email),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        color: profileBg,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  smallText("Business Type", size: 18, clr: Colors.black),
                                  smallText("Contact Number", size: 18, clr: Colors.black),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  smallText(_businessDetailsController.businessTypeName, size: 16),
                                  smallText(_businessDetailsController.phone, size: 16),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              smallText("Description", size: 18, clr: Colors.black),
                              smallText(_businessDetailsController.description, size: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SpinKitThreeBounce(color: primaryColor, size: 30,),
                    ],
                  );
                }
              },
            ),
          ],
        )
      ),
    );
  }
}
