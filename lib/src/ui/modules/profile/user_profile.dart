import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
                leading: CircleAvatar(radius:40,backgroundImage: NetworkImage(_homeTabs.businessId.value != "" ? "$networkImageBaseUrl${_homeTabs.profilePhotoPath.value}" : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")),
                title: Row(
                  children: [
                    smallText(_homeTabs.businessId.value != "" ? "${_homeTabs.userName}" : '', size: 20, clr: Colors.black),
                  ],
                ),
                subtitle: smallText(_homeTabs.businessId.value != "" ? _homeTabs.businessEmail.value : ''),
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
                  var loginDetails = GetStorage();
                  loginDetails.remove("profile");
                  loginDetails.remove("cover");
                  loginDetails.remove("token");
                  loginDetails.remove("userId");
                  loginDetails.remove("email");
                  Get.offAllNamed('/');
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
