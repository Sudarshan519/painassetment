import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddPartyController extends GetxController {
  //TODO: Implement AddPartyController

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

  void submit() {}
}
