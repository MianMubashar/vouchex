import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vouchex/src/controllers/businesses/get_businesses.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../widgets/business_card.dart';
import 'package:get/get.dart';


class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key,}) : super(key: key);

  final TextEditingController search = TextEditingController();
  final GetBusinessesController _businessesController = Get.put(GetBusinessesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 15,),
          Expanded(
            child: PagedListView<int, Datum>(
                pagingController: _businessesController.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Datum>(
                    newPageProgressIndicatorBuilder: (_) => const SpinKitPulse(
                      color: primaryColor,
                    ),
                    itemBuilder: (context, item, index) {
                      return Column(
                        children: [
                          BusinessCard(businessModel: item),
                          if (index == _businessesController.pagingController.itemList!.length - 1)
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              child: smallText("No More Data"),
                            ),
                        ],
                      );
                    }
                )),
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}

