import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class AddAccountController extends GetxController {
  //TODO: Implement AddAccountController
  final name = TextEditingController();
  final startingamt = TextEditingController();
  final DashboardController dashboardController = Get.find();
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
    var res = await requestHandler.sendRequest('POST', ApiEndpoints.account,
        token: dashboardController.token.value,
        requestBody: {
          'name': name.text,
          'asset': true,
          "openingBalance": double.parse(startingamt.text)
        });
    print(res);
    if (res is String) {
    } else {
      Get.back();
    }
  }
}
