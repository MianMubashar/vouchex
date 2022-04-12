
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vouchex/src/data/constants.dart';

class ModalProgress extends StatelessWidget {
  final Widget child;
  final bool call;
   ModalProgress({Key? key, required this.child, required this.call}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ModalProgressHUD(
        inAsyncCall: call,
        progressIndicator: const SpinKitThreeBounce(
          color: primaryColor,
          size: 30,
        ),
        child: child,
      ),
    );
  }
}
