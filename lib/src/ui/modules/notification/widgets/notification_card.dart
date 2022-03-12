import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notificationModel}) : super(key: key);

  final NotificationModel notificationModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(notificationModel.imageUrl, width: 38, height: 38,),
      title: smallText(notificationModel.title, clr: Colors.black),
      subtitle: smallText(notificationModel.subtitle, clr: greyText, size: 14),
    );
  }
}
