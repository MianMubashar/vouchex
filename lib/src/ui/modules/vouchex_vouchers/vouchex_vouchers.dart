import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../home/widgets/voucher_card.dart';


class VouchexVouchers extends StatelessWidget {
   VouchexVouchers({Key? key}) : super(key: key);

   final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Vouchex Vouchers",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left:15, right: 15),
              child: RoundedInputField(
                textEditingController: _search,
                hintText: "Search Businesses",
                icon: Icons.search,
                fillColor: Colors.white,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListView.builder(
                  itemCount: vouchexList.length,
                  itemBuilder: (context, index) {
                    return VoucherCard(model: vouchexList[index], vx: true,);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
