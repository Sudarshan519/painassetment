import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/add_bank_controller.dart';

class AddBankView extends GetView<AddBankController> {
  const AddBankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    // print(controller.dashboardController.token.value);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Add Bank'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formkey,
              child: Column(children: [
                CustomTextField(
                    validator: validateIsEmpty,
                    label: 'Name',
                    controller: controller.name),
                CustomTextField(
                    validator: (v) => validateMinMaxLength(
                        string: v, maxLength: 20, minLegth: 2),
                    label: 'Account Number',
                    isnum: true,
                    controller: controller.accountNo),
                CustomTextField(
                    validator: validateBalance,
                    isnum: true,
                    label: 'Opening Balance',
                    controller: controller.openingBalance),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.teal),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
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
