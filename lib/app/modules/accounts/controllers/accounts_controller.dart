import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';

class AccountsController extends GetxController {
  final DashboardController dashboardController = Get.find();

  final count = 0.obs;
  var accounts = [].obs;
  var accountloading = false.obs;
  var parties = [].obs;
  var partiesloading = false.obs;
  var allAccounts = [].obs;
  getParties() async {
    partiesloading.value = true;
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.party,
        token: dashboardController.token.value);

    parties.addAll(res);
    partiesloading.value = false;
    debugPrint(res);
  }

  getAccount() async {
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.account,
        token: dashboardController.token.value);
    accountloading.value = false;
    accounts.addAll(res);
    allAccounts.addAll(res);
  }

  sendMoney() async {
    var body = {'from': '1', 'to': '2', "amount": 50};
    var res = await requestHandler.sendRequest(
        'POST', '${ApiEndpoints.account}/transaction',
        token: dashboardController.token.value);
  }

  @override
  void onInit() {
    getAccount();
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
