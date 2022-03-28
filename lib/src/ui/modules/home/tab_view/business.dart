import 'package:flutter/material.dart';
import 'package:vouchex/src/controllers/businesses/get_businesses.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../../../../data/model/models.dart';
import '../widgets/business_card.dart';
import 'package:get/get.dart';


class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key}) : super(key: key);

  final TextEditingController search = TextEditingController();
  final GetBusinessesController _businessesController = Get.put(GetBusinessesController());
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
                itemCount: businessList.length,
                itemBuilder: (context, index) {
                  return BusinessCard(businessModel: businessList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
