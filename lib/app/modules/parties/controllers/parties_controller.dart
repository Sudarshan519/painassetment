import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class PartiesController extends GetxController {
  //TODO: Implement PartiesController

  final count = 0.obs;
  var parties = [].obs;
  var partiesloading = false.obs;
  var accounts = [].obs;
  final DashboardController dashboardController = Get.find();
//get parties
  getParties() async {
    partiesloading.value = true;
    parties.clear();
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.party,
        token: dashboardController.token.value);

    parties.addAll(res);
    partiesloading.value = false;
    print(res);
  }

  var banks = [].obs;
  getBanks() async {
    banks.clear();
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.bank,
        token: dashboardController.token.value);
    print(res);
    banks.addAll(res);
  }

  ///accounts

  getAccount() async {
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.account,
        token: dashboardController.token.value);

    accounts.addAll(res);
  }

  @override
  void onInit() {
    getParties();
    getAccount();
    getBanks();
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
