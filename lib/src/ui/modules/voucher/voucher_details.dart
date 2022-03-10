import 'package:flutter/material.dart';
import 'package:vouchex/src/ui/modules/voucher/widgets/voucher_data.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';


class VoucherDetails extends StatelessWidget {
  const VoucherDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }
}
