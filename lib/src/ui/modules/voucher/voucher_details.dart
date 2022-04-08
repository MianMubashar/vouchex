import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/voucher/widgets/voucher_data.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';


class VoucherDetails extends StatelessWidget {
   VoucherDetails({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async{
            voucherDetailsList.clear();
            return true;
          },
          child: Column(
            children:  [
              const CustomAppBar(
                title: "Exchange Requests",
                showLeadingIcon: true,
              ),
              VoucherData()
            ],
          ),
        ),
      ),
    );
  }
}
