import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_bank_controller.dart';

class AddBankView extends GetView<AddBankController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddBankView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddBankView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
