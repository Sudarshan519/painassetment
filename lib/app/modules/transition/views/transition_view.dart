import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

import '../controllers/transition_controller.dart';

class TransitionView extends GetView<TransitionController> {
  const TransitionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => controller.loading.value
              ? Text(
                  '${controller.loading.value}TransitionView is working',
                  style: const TextStyle(fontSize: 20),
                )
              : controller.transactions.isEmpty
                  ? const Text("Empty")
                  : Column(
                      children: controller.transactions
                          .map((element) => Text(element.toString()))
                          .toList()),
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: 'send',
          onPressed: () {
            // Get.toNamed(Routes.ADD_BANK);
          },
          child: const Icon(Icons.send),
        ),
        FloatingActionButton(
          heroTag: 'add',
          onPressed: () {
            // Get.toNamed(Routes.ADD_BANK);
          },
          child: const Icon(Icons.add),
        ),
      ]),
    );
  }
}
