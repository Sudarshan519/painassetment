import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

import '../controllers/accounts_controller.dart';

class AccountsView extends GetView<AccountsController> {
  const AccountsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts Overview'),
        centerTitle: true,
      ),
      body: Obx(() => controller.accountloading.value
          ? const Text("Loading")
          : controller.accounts.isEmpty
              ? const Text("No accounts")
              : Column(
                  children: controller.accounts
                      .map((element) => InkWell(
                          onTap: () {
                            Get.toNamed(Routes.TRANSITION,
                                arguments: element["id"]);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(element.toString()),
                              Text(element['name'].toString()),
                              Text(element['createdAt'].toString()),
                              Text(element['amount'].toString()),

                              const Text('Transactions'),
                              // Text(element['resultingAmount'].toString()),
                              ...element['transactions'].map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(e['detailJson']['tags'][0]
                                          .toString()),
                                      Text(e['amount'].toString()),
                                      // Text(e['createdAt'])
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              )
                              // Text(element['name'].toString()),
                              // ...element['transactions'].map((e) => Text(
                              //     e['detailJson']['tags'].toString() +
                              //         '\n' +
                              //         e["amount"].toString())),
                            ],
                          )))
                      .toList(),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            Routes.ADD_ACCOUNT,
          );
        },
        tooltip: 'Add Account',
        child: Icon(Icons.add),
      ),
    );
  }
}
