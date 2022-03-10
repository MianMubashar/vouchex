import 'package:flutter/material.dart';
import 'package:vouchex/src/data/model/business/business_model.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({Key? key, required this.businessModel}) : super(key: key);

  final BusinessModel businessModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(11)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 10,
                  offset: const Offset(0, 1), // Shadow position
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            height: 190,
          ),
          Image.asset(businessModel.backgroundImage),
          Padding(
            padding: const EdgeInsets.only(top: 35,left: 10),
            child: Image.asset(businessModel.circleImage, width: 80, height: 80,),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 35),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: titleText(businessModel.title, size: 18)),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 100),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: cardText(businessModel.subtitle,)),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset("assets/images/dots_img.png", width: 80, height: 100,),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(businessModel.itemImage, width: 67, height: 90,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
