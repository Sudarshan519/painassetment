import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paymentmanagement/app/modules/auth/controllers/auth_controller.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
        Text('Login',
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
          validator: validatePassword,
          label: 'Password',
          obscureText: true,
          controller: authController.password,
        ),
        SizedBox(
          height: 40,
        ),
        Container(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    authController.loginSubmit();
                  }
                },
                child: Text('Login'))),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            authController.changePage();
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(text: "Don't have account"),
            TextSpan(text: "Signup"),
          ])),
        ),
      ]),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      required this.controller,
      this.validator,
      this.enabled = true,
      this.obscureText = false,
      this.isnum = false})
      : super(key: key);
  final bool isnum;
  final String label;
  final bool enabled;
  final TextEditingController controller;
  final bool obscureText;
  final validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
keyboardType: isnum ? TextInputType.number : null,
      enabled: enabled,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }
}
