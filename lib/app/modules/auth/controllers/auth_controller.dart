import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class AuthController extends GetxController { 

  final count = 0.obs;
  var login = true.obs;

  final username = TextEditingController();
  final password = TextEditingController();
  @override
  void onInit() {
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

  Future<bool> loginSubmit() async {
    var result = await requestHandler.sendRequest('POST', ApiEndpoints.login,
        requestBody: {"username":username.text, "password":password.text});
 
    if (result['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  signupSubmit() async {
    var result = await requestHandler.sendRequest('POST', ApiEndpoints.signup,
        requestBody: {"username":username.text, "password":password.text});

    
    if (result['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
