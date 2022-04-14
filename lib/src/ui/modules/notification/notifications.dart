import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import 'widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
   NotificationsScreen({Key? key}) : super(key: key);

   final NotificationController _notificationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() =>
            Column(
              children: [
                CustomAppBar(
                  title: "Notification",
                  showLeadingIcon: true,
                  leadingIconPressed: () {Get.back();} ,
                ),
                FutureBuilder(
                  future: _notificationController.getNotifications(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      return Expanded(
                          child: _notificationController.notificationsList.isNotEmpty ? ListView.builder(
                            itemCount: _notificationController.notificationsList.length,
                            itemBuilder: (context, index) {
                              return NotificationCard(notificationModel: _notificationController.notificationsList[index]);
                            },
                          ) : Center(
                            child: smallText(_notificationController.noData.value),
                          )
                      );
                    } else {
                      return const Center(
                        child: SpinKitThreeBounce(color: primaryColor, size: 30,),
                      );
                    }
                  },
                )
              ],
            ),
        )
      ),
    );
  }
}
