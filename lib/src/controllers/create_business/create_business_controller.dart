import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateBusinessController extends GetxController{

  var selectedCoverImagePath = ''.obs;
  var selectedProfileImagePath = ''.obs;

  List<String> businessType = ['Design Studio', 'Restaurant'];
  var selectedBusiness = ''.obs;
  var phoneNumber = ''.obs;

  TextEditingController description = TextEditingController();
  TextEditingController vName = TextEditingController();
  TextEditingController vCode = TextEditingController();
  TextEditingController vDescription = TextEditingController();

  void getCoverImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    selectedCoverImagePath.value = pickedImage!.path;
  }

  void getProfileImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    selectedProfileImagePath.value = pickedImage!.path;
  }

}