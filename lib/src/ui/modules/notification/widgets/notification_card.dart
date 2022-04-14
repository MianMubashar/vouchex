import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notificationModel}) : super(key: key);

  final AppNotification notificationModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage("$networkImageBaseUrl${notificationModel.user!.business!.profilePhotoPath!}"),
      ),
      title: smallText(notificationModel.message, clr: Colors.black),
      subtitle: smallText(notificationModel.createdAt.toString(), clr: greyText, size: 14),
    );
  }
}


