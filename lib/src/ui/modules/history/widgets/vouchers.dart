
import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class VoucherHistoryCard extends StatelessWidget {
  final bool? showButtons;
  const VoucherHistoryCard({
    Key? key,
    required this.model,
    this.showButtons = false
  }) : super(key: key);

  final VoucherModel model;
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
                child: Image.asset(model.backgroundImage,),
              ),
              /*CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                foregroundImage: AssetImage(model.circleImage),
              )*/
              Padding(
                padding: const EdgeInsets.only(top: 35,left: 20),
                child: Image.asset(model.circleImage, width: 80, height: 80,),
              ),
              Positioned.fill(
                child: Padding(
                  padding: model.subtitle != null ? const EdgeInsets.only(left: 20, top: 30) : const EdgeInsets.only(left: 20, top: 50),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: titleText(model.title, size: 18)),
                ),
              ),
              if (showButtons == true)
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
                  padding: const EdgeInsets.only(left: 20, top: 100),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: cardText(model.subtitle ?? "",)),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: titleText(model.number, size: 18),
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
