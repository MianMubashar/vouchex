
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class MyVoucherCard extends StatelessWidget {
  const MyVoucherCard({
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
              CachedNetworkImage(
                imageUrl: model.coverPhotoPath,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      foregroundImage: NetworkImage(model.profilePhotoPath),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: titleText(model.name, size: 18)),
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
                            onTap: (){},
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
                            onTap: (){},
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
                    child: titleText(model.code, size: 18),
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
