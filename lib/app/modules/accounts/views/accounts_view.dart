import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

import '../controllers/accounts_controller.dart';

class AccountsView extends GetView<AccountsController> {
  const AccountsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Accounts Overview'),
        centerTitle: true, 
      ),
      body: Obx(() => controller.accountloading.value
          ? const Text("Loading")
          : controller.accounts.isEmpty
              ? const Text("No accounts")
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            height: 60,
                            width: 120,
                            child: PopupMenuButton(
                                child: Center(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.filter_list,
                                      color: Colors.grey[800],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Filter By",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                                itemBuilder: (_) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.accounts.clear();
                                          controller.accounts.addAll(controller
                                              .allAccounts
                                              .where((p0) =>
                                                  p0['externallyManaged'] ==
                                                  false));
                                        },
                                        child: const Text('Internally Managed'),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.accounts.clear();
                                          controller.accounts.addAll(controller
                                              .allAccounts
                                              .where((p0) =>
                                                  p0['externallyManaged'] ==
                                                  true));
                                        },
                                        child: const Text('Externally Managed'),
                                      ),
                                    ]),
                          ),
                        ),
                        ...controller.accounts
                            .map((element) => SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.TRANSITION,
                                            arguments: element["id"]);
                                      },
                                      child: Card(
                                        color: Colors.green[100],
                                        shadowColor: Colors.purpleAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  DateFormat.yMMMEd()
                                                      .format(DateTime.parse(
                                                          element['createdAt']))
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                      color: Colors.grey[700]),
                                                ),
                                              ),

                                              const Text("BANK NAME"),
                                              Text(
                                                element['name']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.teal),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              // Text("Externally Managed"),
                                              // Text(element['externallyManaged']
                                              //     .toString()),
                                              const Text(
                                                'Last Transaction',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              ...element['transactions']
                                                  .map((e) => Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(e['detailJson']
                                                                  ['tags'][0]
                                                              .toString()
                                                                .capitalize!,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "Transaction Amount ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            'Rs.${e['amount']}',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Total Amount ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Text(
                                                                'Rs.${e['resultingAmount']}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          )
                                                          // Text(e['createdAt'])
                                                        ],
                                                      )),
                                              const SizedBox(
                                                height: 20,
                                              )
                                              // Text(element['name'].toString()),
                                              // ...element['transactions'].map((e) => Text(
                                              //     e['detailJson']['tags'].toString() +
                                              //         '\n' +
                                              //         e["amount"].toString())),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ]),
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.toNamed(
            Routes.ADD_ACCOUNT,
          );
        },
        tooltip: 'Add Account',
        child: const Icon(Icons.add),
      ),
    );
  }
}
