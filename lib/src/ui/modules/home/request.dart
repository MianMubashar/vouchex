import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: "Exchange Requests",
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: voucherList.length,
                itemBuilder: (context, index) {
                  return VoucherCard(model: voucherList[index], vx: false,);
              },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
