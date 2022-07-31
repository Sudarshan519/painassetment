import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';

class AuthController extends GetxController {
  final count = 0.obs;
  var login = true.obs;

  final username = TextEditingController();
  final password = TextEditingController();
  @override
  void onInit() {
    username.text = "abc@gmail.com";
    password.text = "def@gmail.com";
    super.onInit();
  }

  changePage() {
    login.toggle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  loginSubmit() async {
    Get.dialog(AlertDialog(
      content: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        color: Colors.white,
        child: const CircularProgressIndicator(),
      ),
    )); 
    var result = await requestHandler.sendRequest('POST', ApiEndpoints.login,
        requestBody: {"username": username.text, "password": password.text});
    Get.back();
    if (result['status'] == "error") {
      getSnackbar(message: result['message']);
    } else {
      Get.offNamed(Routes.DASHBOARD, arguments: result);
    }
  }

  signupSubmit() async {
    var result = await requestHandler.sendRequest('POST', ApiEndpoints.signup,
        requestBody: {"username": username.text, "password": password.text});

    if (result['status'] == "error") {
      getSnackbar(message: result['message']);
    } else {
      Get.offNamed(Routes.DASHBOARD, arguments: result);
    }
  }
}
