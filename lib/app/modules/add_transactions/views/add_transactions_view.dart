import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_transactions_controller.dart';

class AddTransactionsView extends GetView<AddTransactionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddTransactionsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddTransactionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
