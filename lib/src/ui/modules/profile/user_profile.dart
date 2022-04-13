import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/authentication.dart';
import 'package:vouchex/src/ui/modules/profile/profile_list_tile.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class UserProfileScreen extends StatelessWidget {
   UserProfileScreen({Key? key}) : super(key: key);

  final AuthService authService = AuthService();
   final HomeTabs _homeTabs = Get.put(HomeTabs());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Profile",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListTile(
                contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                tileColor: profileBg,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                leading: Image.asset("assets/images/profile_img_1.png", width: 55, height: 55,),
                title: Row(
                  children: [
                    smallText("North 9 Designs", size: 20, clr: Colors.black),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.edit_outlined, color: primaryColor,),
                    ),
                  ],
                ),
                subtitle: smallText("North 9 Designs@gmail.com"),
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(color: const Color(0XFFE1E1E1), height: 0.5,),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: profileItems.length,
                itemBuilder: (context, index){
                  return ProfileListTile(profileModel: profileItems[index],);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: RoundedButtonSolidColor(
                onPress: (){
                  /*authService.signOut();
                  Get.offAllNamed('/');*/
                  Get.offAndToNamed('/BottomBar'); 
                  },
                title: 'Log Out',
              ),
            )
          ],
        ),
      ),
    );
  }
}
