import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:vouchex/src/controllers/vouchex_vouchers/purchase_vouchex_voucher_controller.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class StripeController extends GetxController{

  Map<String, dynamic>? paymentIntentData;
  PurchaseVouchexVoucherController _purchaseVouchexVoucherController=Get.put(PurchaseVouchexVoucherController());

  Future<void> makePayment(String amount,int voucherId) async {
    try {

      paymentIntentData =
      await createPaymentIntent(amount, 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: false,
              googlePay: false,
              testEnv: true,
              merchantCountryCode: 'US',
              merchantDisplayName: 'Vouchex')).then((value){
      });
      ///now finally display payment sheet
     await displayPaymentSheet(amount,voucherId);
    } catch (e, s) {
      if (kDebugMode) {
        print('exception:$e$s');
      }
    }
  }

  displayPaymentSheet(String amount,int voucherId) async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          )).then((newValue) async {


        print('payment intent'+paymentIntentData!['id'].toString());
        print('payment intent'+paymentIntentData!['client_secret'].toString());
        print('payment intent'+paymentIntentData!['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());

        await _purchaseVouchexVoucherController.requestPurchaseVouchexVoucher(Get.context!, voucherId, amount);
        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      ImageDialog(
          title: 'Cancelled',
          imageUrl: 'assets/images/error_img.png').show(Get.context!);
    } catch (e) {
      print('$e');
    }
  }


  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      if (kDebugMode) {
        print(body);
      }
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51KeI62B3gOhC8ewaNRN6vhosNWUyYpaT7BZ3TWDyrTkl8GNq3OZ2yaiQYNdSXwAtQcyZAdR1HLcFvDufkFYeDW5h00mwzq29r6',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      if (kDebugMode) {
        print('Create Intent reponse ===> ${response.body.toString()}');
      }
      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('err charging user: ${err.toString()}');
      }
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }

}