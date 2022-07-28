import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

import '../controllers/banks_controller.dart';

class BanksView extends GetView<BanksController> {
  const BanksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Banks'),
        centerTitle: true,
      ),
      body: Obx(() => controller.bankloading.value
          ? const Text("Loading")
          : controller.banks.isEmpty
              ? const Text("No accounts")
              : SingleChildScrollView(
                  child: Column(
                    children: controller.banks
                        .map((element) => ListTile(
                              leading: const Icon(Icons.account_balance),
                              subtitle:
                                  Text(element['accountNumber'].toString()),
                              title: Text(element['name'].toString()),
                            ))
                        .toList(),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(Routes.ADD_BANK);
          controller.getBanks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
