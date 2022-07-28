import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class AddBankController extends GetxController {
  //TODO: Implement AddBankController
  final DashboardController dashboardController = Get.find();
  var name = TextEditingController();
  var accountNo = TextEditingController();
  var openingBalance = TextEditingController();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void submit() async {
    var res = await requestHandler.sendRequest('POST', ApiEndpoints.bank,
        token: dashboardController.token.value,
        requestBody: {
          "name": name.text,
          "accountNumber": int.parse(accountNo.text),
          "openingBalance": double.parse(openingBalance.text)
        });
    if (res is String) {
      getSnackbar(message: res, bgColor: Colors.red);
    } else {
      print(res);
      Get.back();
    }
  }
}
