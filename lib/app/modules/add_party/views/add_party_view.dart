import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/add_party_controller.dart';

class AddPartyView extends GetView<AddPartyController> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Add Payment Party'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formkey,
              child: Column(children: [
                CustomTextField(
                    validator: validateIsEmpty,
                    label: 'Name',
                    controller: controller.name),
                CustomTextField(
                    validator: (v) => validateMinLength(string: v, length: 3),
                    label: 'Address',
                    controller: controller.address),
                CustomTextField(
                    validator: validatePhone,
                    isnum: true,
                    label: 'Phone',
                    controller: controller.phone),
                CustomTextField(
                    validator: (v) => validateEmail(v),
                    label: 'email',
                    controller: controller.email),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
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
