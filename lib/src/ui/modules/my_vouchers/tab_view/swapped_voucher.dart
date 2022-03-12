import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/history/modules.dart';

class SwappedVoucher extends StatelessWidget {
  const SwappedVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: swappedVoucherList.length,
                itemBuilder: (context, index) {
                  return VoucherHistoryCard(model: swappedVoucherList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
