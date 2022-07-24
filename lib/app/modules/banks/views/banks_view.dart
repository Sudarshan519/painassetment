import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

import '../controllers/banks_controller.dart';

class BanksView extends GetView<BanksController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Banks'),
        centerTitle: true,
      ),
      body: Obx(() => controller.bankloading.value
          ? const Text("Loading")
          : controller.banks.isEmpty
              ? const Text("No accounts")
              : Column(
                  children: controller.banks
                      .map((element) => Card(child: Text(element.toString())))
                      .toList(),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_BANK);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
