import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class ChequeTransactionsController extends GetxController {
  final DashboardController dashboardController = Get.find();
  final count = 0.obs;
  var cheques = [].obs;
  var loading = false.obs;
  @override
  void onInit() {
    getChequeTransactions();
    super.onInit();
  }

  getChequeTransactions() async {
    var body = {
      "pending": true,
      "bounced": false,
      "received": false,
      "partyId": 1
    };
    cheques.clear();
    var resp = await requestHandler.sendRequest(
        'GET', "${ApiEndpoints.party}/cheque/transactions",
        token: dashboardController.token.value, requestBody: body);
    if (resp is String) {
      getSnackbar(message: resp);
    } else {
      cheques.addAll(resp);
    }
  }

  bounceCheque(element) async {
    // Get.dialog(AlertDialog())
    var resp = await requestHandler.sendRequest(
        'POST', "${ApiEndpoints.party}/cheque/bounce",
        token: dashboardController.token.value,
        requestBody: {
          "bankId": element["bankId"],
          "chequeNumber": element["chequeNumber"],
          "description": element['detailJson']['decsription'],
          "bounceDate": DateTime.now().toIso8601String()
        });
    // print(resp);
    if (resp is String) {
      getSnackbar(message: resp);
    } else {
      cheques.addAll(resp);
    }
  }

  clearCheque(element) async {
    var resp = await requestHandler.sendRequest(
        'POST', "${ApiEndpoints.party}/cheque/clear",
        token: dashboardController.token.value,
        requestBody: {
          "bankId": element["bankId"],
          "chequeNumber": element["chequeNumber"],
          "description": element['detailJson']['decsription'],
          "postTo": 1
        });
    print(resp);
    if (resp is String) {
      getSnackbar(message: resp);
    } else {
      cheques.addAll(resp);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
