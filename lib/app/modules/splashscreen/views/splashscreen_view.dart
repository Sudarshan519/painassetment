import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);

  navigate() {
    Timer(0.seconds, () {
      Get.offAllNamed(Routes.AUTH);
    });
  }

  @override
  Widget build(BuildContext context) {
    navigate();
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
