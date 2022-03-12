import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import 'widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Notification",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notificationsList.length,
                itemBuilder: (context, index) {
                  return NotificationCard(notificationModel: notificationsList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
