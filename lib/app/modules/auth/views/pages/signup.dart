import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/modules/auth/controllers/auth_controller.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final formkey = GlobalKey<FormState>();
    return Form(
      key: formkey,
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        Text('Signup',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        CustomTextField(
          validator: validateIsEmpty,
          label: 'Username',
          controller: authController.username,
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextField(
          validator: validateIsEmpty,
          label: 'Password',
          obscureText: true,
          controller: authController.password,
        ),
        // CustomTextField(
        //   // validator: validateIsEmpty,
        //   label: 'Company Name',
        //   obscureText: true,
        //   controller: authController.password,
        // ),
        // CustomTextField(
        //   // validator: validateIsEmpty,
        //   label: 'Company VAT',
        //   obscureText: true,
        //   controller: authController.password,
        // ),
        // CustomTextField(
        //   validator: validateIsEmpty,
        //   label: 'Email',
        //   obscureText: true,
        //   controller: authController.password,
        // ),
        // CustomTextField(
        //   validator: validateIsEmpty,
        //   label: 'Phone',
        //   obscureText: true,
        //   controller: authController.password,
        // ),
        SizedBox(
          height: 40,
        ),
        Container(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    authController.signupSubmit();
                  }
                },
                child: Text('Signup'))),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            authController.changePage();
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(text: "Already have account"),
            TextSpan(text: "Sign In"),
          ])),
        ),
      ]),
    );
  }
}
