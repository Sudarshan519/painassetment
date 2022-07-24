import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class PartiesController extends GetxController {
  //TODO: Implement PartiesController

  final count = 0.obs;
  var parties = [].obs;
  var partiesloading = false.obs;
  final DashboardController dashboardController = Get.find();
//get parties
  getParties() async {
    partiesloading.value = true;
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.party,
        token: dashboardController.token.value);

    parties.addAll(res);
    partiesloading.value = false;
    print(res);
  }

  @override
  void onInit() {
    getParties();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
