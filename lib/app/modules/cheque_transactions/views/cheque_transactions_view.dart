import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/cheque_transactions_controller.dart';

class ChequeTransactionsView extends GetView<ChequeTransactionsController> {
  const ChequeTransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('ChequeTransactionsView'),
        centerTitle: true,
        // actions: [
        //   PopupMenuButton(
        //       child: Center(
        //           child: Row(
        //         children: [Icon(Icons.filter_list), Text("Filter By")],
        //       )),
        //       itemBuilder: (_) => [
        //             PopupMenuItem(
        //               onTap: () {
        //                 controller.isPending.value = true;
        //                 controller.bounced.value = false;
        //                 controller.getChequeTransactions();
        //               },
        //               child: const Text('Pending'),
        //             ),
        //             PopupMenuItem(
        //               onTap: () {
        //                 controller.isPending.value = true;
        //                 controller.bounced.value = true;
        //                 controller.received.value = false;
        //                 controller.getChequeTransactions();
        //               },
        //               child: const Text('Bounced'),
        //             ),
        //             PopupMenuItem(
        //               onTap: () {
        //                 controller.isPending.value = false;
        //                 controller.bounced.value = false;
        //                 controller.received.value = true;
        //                 controller.getChequeTransactions();
        //               },
        //               child: const Text('Received'),
        //             ),
        //           ]),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: controller.loading.value
            ? const Text("Loading")
            : Column(children: [
                Obx(() => Column(
                      children: controller.cheques
                          .map((element) => Card(
                                shadowColor: Colors.pink,
                                // color: Colors.green[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(element.toString()),
                                      Row(
                                        children: [
                                          Text(
                                            element['drCr'] == true
                                                ? 'Debit'
                                                : "Credit",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            DateFormat.yMMMEd().format(
                                                DateTime.parse(
                                                    element['chequeDate']
                                                        .toString())),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Cheque no.",
                                              style: TextStyle(
                                                 fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              ": ${element['chequeNumber']}",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Amount ",
                                              style: TextStyle(
                                                 fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              ': Rs. ${element['amount']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                     
                                        Row(
                                          children: [
                                          const Expanded(
                                            child: Text(
                                              "Bounce : ",
                                              style: TextStyle(
                                                fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              ": ${element['bounce']} times",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          ],
                                        ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      const Text(
                                        "Remarks",
                                        style: TextStyle(
                                            fontSize: 16),
                                      ),
                                      Text(
                                        element['detailJson']['decsription']
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          if (!element['isProcessing'])
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  primary: Colors.teal,
                                                ),
                                                onPressed: () {
                                                  controller
                                                      .bounceCheque(element);
                                                },
                                                child: const Text("Bounce")),
                                          const SizedBox(width: 10),
                                          if (!element['isProcessing'])
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  primary: Colors.teal,
                                                ),
                                                onPressed: () {
                                                  var formKey =
                                                      GlobalKey<FormState>();
                                                  Get.dialog(AlertDialog(
                                                    content: Form(
                                                      key: formKey,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          DropdownButtonFormField(
                                                              value: controller
                                                                  .selectedAccountId
                                                                  .value,
                                                              validator:
                                                                  validateIsEmpty,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          'Choose'),
                                                              items: [
                                                                const DropdownMenuItem(
                                                                  value: '',
                                                                  child: Text(
                                                                      'Choose'),
                                                                ),
                                                                ...controller
                                                                    .accounts
                                                                    .where((p0) =>
                                                                        p0['externallyManaged'] ==
                                                                        true)
                                                                    .map(
                                                                      (element) =>
                                                                          DropdownMenuItem(
                                                                        value: element['id']
                                                                            .toString(),
                                                                        child: Text(
                                                                            element['name']),
                                                                      ),
                                                                    ),
                                                              ],
                                                              onChanged:
                                                                  (String? v) {
                                                                if (v != '') {
                                                                  controller
                                                                      .selectedAccountId
                                                                      .value = v!;
                                                                }
                                                              }),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              if (formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller
                                                                    .clearCheque(
                                                                        element);
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Subimit'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                child: const Text("Clear"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    )),
              ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal,
          onPressed: () {
            Get.bottomSheet(
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Obx(
                            () => Checkbox(
                                activeColor: Colors.teal,
                                value: controller.isPending.value,
                                onChanged: (value) {
                                  controller.isPending.value = value!;
                                }),
                          ),
                          const Text("Pending"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Obx(() => Checkbox(
                              activeColor: Colors.teal,
                              value: controller.bounced.value,
                              onChanged: (value) {
                                controller.bounced.value = value!;
                              })),
                          const Text("Bounced"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Obx(() => Checkbox(
                              activeColor: Colors.teal,
                              value: controller.received.value,
                              onChanged: (value) {
                                controller.received.value = value!;
                              })),
                          const Text("Receiving"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 50,
                        width: Get.size.width * .8,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                primary: Colors.teal),
                            onPressed: () {
                              controller.getChequeTransactions();
                              Get.back();
                            },
                            child: const Text("Submit"))),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
                ),
                isScrollControlled: true);
          },
          label: Row(
            children: const [
              Icon(Icons.filter_list),
              Text("Filter"),
            ],
          )),
    );
  }
}
