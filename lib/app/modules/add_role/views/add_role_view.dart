import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_role_controller.dart';

class AddRoleView extends GetView<AddRoleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddRoleView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddRoleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
