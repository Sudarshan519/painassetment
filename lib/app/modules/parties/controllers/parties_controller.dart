 
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';

class PartiesController extends GetxController {
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
  }

  var banks = [].obs;
  getBanks() async {
    banks.clear();
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.bank,
        token: dashboardController.token.value);

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
  void onClose() {}
  void increment() => count.value++;
}
