import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class RequestScreen extends StatelessWidget {
   RequestScreen({Key? key}) : super(key: key);

  final PendingExchangeRequestController _exchangeRequestController = Get.put(PendingExchangeRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  const CustomAppBar(
                    title: "Exchange Requests",
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _exchangeRequestController.fetchPendingRequests(isRefresh: true);
                        },
                        child: PagedListView<int, PEData>(
                          pagingController: _exchangeRequestController.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<PEData>(
                              itemBuilder: (context, item, index) {
                                return Column(
                                  children: [
                                    PendingRequestCard(model: item),
                                    if (index == _exchangeRequestController.pagingController.itemList!.length - 1)
                                      Container(
                                        padding: const EdgeInsets.all(15.0),
                                        child: smallText("No More Data"),
                                      ),
                                  ],
                                );
                              }
                          ),
                        ),
                      )
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        )
    );
  }

}

/*
class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  final PendingExchangeRequestController _exchangeRequestController = Get.put(PendingExchangeRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  const CustomAppBar(
                    title: "Exchange Requests",
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                      child: PagedListView<int, PEData>(
                        pagingController: _exchangeRequestController.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<PEData>(
                            itemBuilder: (context, item, index) {
                              return Column(
                                children: [
                                  PendingRequestCard(model: item),
                                  if (index == _exchangeRequestController.pagingController.itemList!.length - 1)
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      child: smallText("No More Data"),
                                    ),
                                ],
                              );
                            }
                        ),
                      )
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        )
    );
  }
}
*/

