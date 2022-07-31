import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/cheque_transactions_controller.dart';

class ChequeTransactionsView extends GetView<ChequeTransactionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ChequeTransactionsView'),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                child: const Center(child: Text("Filter By")),
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: controller.loading.value
              ? const Text("Loading")
              : Column(children: [
                  Obx(() => Column(
                        children: controller.cheques
                            .map((element) => Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(element.toString()),
                                      Text(element['drCr'] == true
                                          ? 'Debit'
                                          : "Credit"),
                                      Text(element['chequeDate'].toString()),
                                      const Text("Cheque Number"),
                                      Text(element['chequeNumber'].toString()),
                                      const Text("Amount"),
                                      Text(element['amount'].toString()),
                                      const Text("Bounce"),
                                      Text(element['bounce'].toString()),
                                      const Text("Description"),
                                      Text(element['detailJson']['decsription']
                                          .toString()),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .bounceCheque(element);
                                                },
                                                child: const Text("Bounce")),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
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
                                                child: const Text("Clear")),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      )),
                ]),
        ));
  }
}
