import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/modules/modules.dart';
import '../../widgets/global_widgets.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key,}) : super(key: key);

   final HomeTabs _homeTabs = Get.put(HomeTabs());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          SafeArea(
            child: Column(
              children: [
                FutureBuilder(
                  future: _homeTabs.validateToken(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      return InkWell(
                        onTap: () {
                          print(_homeTabs.profilePhotoPath.value);
                          if(_homeTabs.userName.value == "") {
                            Get.toNamed('/CreateBusiness');
                          } else {
                            Get.toNamed('/Profile');
                          }

                        },
                        child: CustomAppBar(
                          title: _homeTabs.userName.value != "" ? "Welcome ${_homeTabs.userName.value}" : "Register as Business for\nmore features",
                          textAlign: TextAlign.start,
                          showTrailingIcon: true,
                          profileImage: _homeTabs.userName.value != "" ? "$networkImageBaseUrl${_homeTabs.profilePhotoPath.value}" : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                        ),
                      );
                    } else {
                      return const Center(
                        child: SpinKitThreeBounce(color: primaryColor, size: 25,),
                      );
                    }
                  },
                ),
                const SizedBox(height: 5,),
                Container(
                  color: secondaryColor,
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700,fontFamily: 'Nunito'),
                    unselectedLabelStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Nunito'),
                    indicatorColor: primaryColor,
                    tabs: _homeTabs.tabs,
                    controller: _homeTabs.controller,
                    indicator: const BoxDecoration(
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _homeTabs.controller,
                    children: [
                      BusinessScreen(),
                      VouchersScreen()
                    ],
                  ),
                )
              ],
            ),
          ),
      )
    );
  }
}
