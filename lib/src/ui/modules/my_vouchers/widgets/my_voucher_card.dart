
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class MyVoucherCard extends StatelessWidget {
   MyVoucherCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final MyVouchersData model;
  final MyVoucherController _myVoucherController = Get.put(MyVoucherController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 20,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/voucher_card.png",),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 9),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  ),
                  child: CachedNetworkImage(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    imageUrl: "$networkImageBaseUrl${model.business!.coverPhotoPath}",
                    placeholder: (context, url) => const SpinKitPulse(color: primaryColor, size: 25,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),

                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      foregroundImage: NetworkImage("$networkImageBaseUrl${model.business!.profilePhotoPath}",),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: titleText(model.name!, size: 18)),
                ),
              ),
              Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 120),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              var voucherData  = {
                                "name" : model.name,
                                "code" : model.code,
                                "selectedServiceTitle" : model.service!.map((e) => e.title).toList(),
                                "selectedServiceId" : model.service!.map((e) => e.id).toList(),
                                "expiry" : model.expiry,
                                "market_value" : model.marketValue,
                                "terms" : model.termsConditions,
                                "is_static" : model.isStatic,
                                "v_id" : model.id,
                              };
                              Get.toNamed("/CreateNewVoucher", arguments: voucherData);
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/edit_icon.png", width: 17, height: 17,),
                                const SizedBox(width: 5,),
                                cardText("Edit Voucher"),
                              ],
                            ),
                          ),
                          const SizedBox(width: 7,),
                          InkWell(
                            onTap: (){
                              Get.defaultDialog(
                                title: 'Alert!',
                                content: smallText("Are you sure you want to delete?"),
                                textCancel: 'No',
                                textConfirm: 'Yes',
                                onCancel: () {
                                  Get.back();
                                },
                                onConfirm: () {
                                  _myVoucherController.deleteVoucher(model.id!);
                                  Get.back();
                                }
                              );
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/delete_icon.png", width: 17, height: 17,),
                                const SizedBox(width: 5,),
                                cardText("Delete Voucher"),
                              ],
                            ),
                          )
                        ],
                      ),),
                  ),
                ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: titleText(model.code != null ?"#"+model.code!:'', size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}


class VoucherListCard extends StatelessWidget {
  const VoucherListCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final MyVouchersData model;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 20,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/voucher_card.png",),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 9),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  ),
                  child: CachedNetworkImage(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    imageUrl: "$networkImageBaseUrl${model.business!.coverPhotoPath}",
                    placeholder: (context, url) => const SpinKitPulse(color: primaryColor, size: 25,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),

                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      foregroundImage: NetworkImage("$networkImageBaseUrl${model.business!.profilePhotoPath}",),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: titleText(model.name!, size: 18)),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: titleText(model.code != null ?"#"+model.code!:'', size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
