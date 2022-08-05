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
        backgroundColor: Theme.of(context).primaryColor,
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
                              leading: const Icon(
                                Icons.account_balance,
                                color: Colors.teal,
                              ),
                              // trailing: Text(element.toString()),
                              subtitle:
                                  Text(
                                'Account Number :' +
                                    element['accountNumber'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600]),
                              ),
                              title: Text(
                                'Bank Name : ' +
                                    element["name"].toString().toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ))
                        .toList(),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          await Get.toNamed(Routes.ADD_BANK);
          controller.getBanks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
