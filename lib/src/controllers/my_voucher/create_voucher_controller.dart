
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateVoucherController extends GetxController {

  TextEditingController vName = TextEditingController();
  TextEditingController vCode = TextEditingController();
  TextEditingController marketValue = TextEditingController();
  TextEditingController terms = TextEditingController();

  var selectedDate = DateTime.now().obs;
  List<String> services = ['Mockup designs 1', 'Mockup designs 2', 'Mockup designs 3', 'Mockup designs 4'];
  var selectedService = ''.obs;
  var groupValue = 3.obs;

  selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      helpText: 'Select Date',
      cancelText: 'Close',
      confirmText: 'Ok',
      errorFormatText: 'Enter Valid Date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Select',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }
}