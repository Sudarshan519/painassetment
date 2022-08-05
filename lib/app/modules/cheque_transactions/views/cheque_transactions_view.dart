import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/cheque_transactions_controller.dart';

class ChequeTransactionsView extends GetView<ChequeTransactionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('ChequeTransactionsView'),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                child: Center(
                    child: Row(
                  children: [Icon(Icons.filter_list), Text("Filter By")],
                )),
                itemBuilder: (_) => [
                      PopupMenuItem(
                        onTap: () {
                          controller.isPending.value = true;
                          controller.bounced.value = false;
                          controller.getChequeTransactions();
                        },
                        child: const Text('Pending'),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          controller.isPending.value = true;
                          controller.bounced.value = true;
                          controller.received.value = false;
                          controller.getChequeTransactions();
                        },
                        child: const Text('Bounced'),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          controller.isPending.value = false;
                          controller.bounced.value = false;
                          controller.received.value = true;
                          controller.getChequeTransactions();
                        },
                        child: const Text('Received'),
                      ),
                    ]),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: controller.loading.value
              ? const Text("Loading")
              : Column(children: [
                  Obx(() => Column(
                        children: controller.cheques
                            .map((element) => Card(
                                  color: Colors.green[100],
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
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              DateFormat.yMMMEd().format(
                                                  DateTime.parse(
                                                      element['chequeDate']
                                                          .toString())),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Cheque Number : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(element['chequeNumber']
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Amount : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text('Rs. ' +
                                                element['amount'].toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Bounce : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(element['bounce'].toString()),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        const Text(
                                          "Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(element['detailJson']
                                                ['decsription']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.teal,
                                                ),
                                                onPressed: () {
                                                  controller
                                                      .bounceCheque(element);
                                                },
                                                child: const Text("Bounce")),
                                            const SizedBox(width: 10),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
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
        ));
  }
}
