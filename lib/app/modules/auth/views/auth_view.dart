import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/signup.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
        child: SafeArea(child: Obx(()=>controller.login.value? const Login():Signup())))
    );
  }
}
