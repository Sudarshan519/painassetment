import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/accounts/controllers/accounts_controller.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';
import 'package:paymentmanagement/app/utils/storage_service.dart';

class TransitionController extends GetxController {
  final DashboardController dashboardController = Get.find();
  final AccountsController accountsController = Get.find();
  var loading = false.obs;
  var transactions = [].obs;
  getTransactions() async {
    loading.value = true;
    var res = await requestHandler.sendRequest(
        'GET', ApiEndpoints.gettransactions + Get.arguments.toString(),
        token: dashboardController.token.value);
    loading.toggle();
    transactions.addAll(res);
  }

  var parties = [].obs;
  var partiesloading = false.obs;
  getParties() async {
    partiesloading.value = true;
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.party,
        token: dashboardController.token.value);

    parties.addAll(res);
    partiesloading.value = false; 
  }

  @override
  void onInit() {
    super.onInit();
    var id = Get.arguments;
    getTransactions();
    getParties();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
