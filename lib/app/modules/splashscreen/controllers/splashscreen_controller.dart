import 'dart:async';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

class SplashscreenController extends GetxController { 
  final count = 0.obs;
  @override
  void onInit() {
    navigate();
    super.onInit();
  }

  navigate() {
    Timer(3.seconds, () {
      Get.toNamed(Routes.DASHBOARD);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
