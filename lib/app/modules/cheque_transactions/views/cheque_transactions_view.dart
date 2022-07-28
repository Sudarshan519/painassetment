import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cheque_transactions_controller.dart';

class ChequeTransactionsView extends GetView<ChequeTransactionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ChequeTransactionsView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: controller.loading.value
              ? Text("Loading")
              : Column(children: [
                  Obx(() => Column(
                        children: controller.cheques
                            .map((element) => Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(element.toString()),
                                      Text(element['drCr'] == true
                                          ? 'Debit'
                                          : "Credit"),
                                      Text(element['chequeDate'].toString()),
                                      const Text("Cheque Number"),
                                      Text(element['chequeNumber'].toString()),
                                      const Text("Amount"),
                                      Text(element['amount'].toString()),
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
                                                  controller
                                                      .clearCheque(element);
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
