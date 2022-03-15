import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class VouchersScreen extends StatelessWidget {
   VouchersScreen({Key? key}) : super(key: key);

   final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left:15, right: 15),
              child: RoundedInputField(
                textEditingController: search,
                hintText: "Search Businesses",
                icon: Icons.search,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
            ),
            const SizedBox(height: 15,),
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
