import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/add_account_controller.dart';

class AddAccountView extends GetView<AddAccountController> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('AddAccount'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(children: [
                CustomTextField(
                    validator: validateIsEmpty,
                    label: 'label',
                    controller: controller.name),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    validator: (v) => validateMinLength(string: v, length: 3),
                    label: 'openingBalance',
                    controller: controller.startingamt),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.teal),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            controller.submit();
                          }
                        },
                        child: const Text('Submit')))
              ]),
            ),
          ),
        ));
  }
}
