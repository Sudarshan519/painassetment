import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class AddPartyController extends GetxController {
  final DashboardController dashboardController = Get.find();
  final count = 0.obs;
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
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
    var res = await requestHandler.sendRequest('POST', ApiEndpoints.party,
        token: dashboardController.token.value,
        requestBody: {
          "name": name.text,
          "address": address.text,
          "phone": phone.text,
          "email": email.text,
        });
    if (res is String) {
      getSnackbar(message: res, bgColor: Colors.red);
    } else {
      Get.back();
    }
  }
}
