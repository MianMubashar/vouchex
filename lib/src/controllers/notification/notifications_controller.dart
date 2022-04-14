import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class NotificationController extends GetxController {
  var notificationsList = <AppNotification>[].obs;
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  Future<List<AppNotification>> getNotifications() async {
    var token = loginDetails.read("token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/fetch-notifications", token);
    if (response != null) {
      final result = notificationsModelFromJson(response);
      if (result.notifications!.isEmpty) {
        noData.value = "No Notifications";
      }
      notificationsList.value = result.notifications!;
    }
    isLoading.value = false;
    return notificationsList;
  }

  @override
  void onInit() async {
    super.onInit();
  }
}