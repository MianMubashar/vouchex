import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import '../../../controllers/controllers.dart';
import '../../../data/constants.dart';

class ProfileListTile extends StatelessWidget {
   ProfileListTile({Key? key, required this.profileModel}) : super(key: key);

   final ProfileModel profileModel;
   @override
   Widget build(BuildContext context) {
     MyBusinessDetailsController _businessDetailsController = Get.isRegistered<MyBusinessDetailsController>()
         ? Get.find<MyBusinessDetailsController>()
         : Get.put(MyBusinessDetailsController());
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ListTile(
        onTap: (){
          if(profileModel == profileItems[0]){
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

            Get.toNamed(profileModel.route,arguments: data);
          }else{
            Get.toNamed(profileModel.route);
          }
        },
        contentPadding: EdgeInsets.zero,
        tileColor: Colors.white,
        leading: Image.asset(profileModel.imageUrl, width: 27, height: 27,),
        title: smallText(profileModel.title, clr: Colors.black, size: 18),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,),
      ),
    );
  }
}
