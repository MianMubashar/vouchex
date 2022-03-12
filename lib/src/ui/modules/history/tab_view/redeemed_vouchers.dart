import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/history/modules.dart';

class RedeemedVouchers extends StatelessWidget {
  const RedeemedVouchers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: voucherList.length,
                itemBuilder: (context, index) {
                  return VoucherHistoryCard(model: voucherList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
