import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class ProfileListTile extends StatelessWidget {
   const ProfileListTile({Key? key, required this.profileModel}) : super(key: key);

   final ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        tileColor: Colors.white,
        leading: Image.asset(profileModel.imageUrl, width: 27, height: 27,),
        title: smallText(profileModel.title, clr: Colors.black, size: 18),
        trailing: IconButton(
          onPressed: (){Get.toNamed(profileModel.route);},
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,),
        ),
      ),
    );
  }
}
