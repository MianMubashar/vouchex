import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import '../../history/modules.dart';

class MyVoucher extends StatelessWidget {
  const MyVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: myVoucherList.length,
                  itemBuilder: (context, index) {
                    return VoucherHistoryCard(model: myVoucherList[index], showButtons: true,);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
