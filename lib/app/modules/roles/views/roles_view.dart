import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/roles_controller.dart';

class RolesView extends GetView<RolesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RolesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RolesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
