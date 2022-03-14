import 'package:get/get.dart';

class SearchController extends GetxController{
  var business = false.obs;
  var voucher = false.obs;

  var selectedValue = ''.obs;
  List selectedBusinessType = [];
  String result = '';
}