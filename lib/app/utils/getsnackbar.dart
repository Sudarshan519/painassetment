import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getSnackbar(
        {String? message,
        Color? bgColor,
        IconData? leadingIcon,
        Duration? duration = const Duration(seconds: 5)}) =>
    Get.showSnackbar(
      GetSnackBar(
        onTap: (value) {
          Get.back();
        },
        duration: duration!, //const Duration(milliseconds: 1600),
        message: message ?? "message",
        animationDuration: const Duration(milliseconds: 600),
        isDismissible: true,
        shouldIconPulse: false,
        dismissDirection: DismissDirection.horizontal,
        icon: Icon(
          leadingIcon, //?? Icons.info_outline,
          color: Colors.white,
        ),
        backgroundColor: bgColor ?? Colors.red,
      ),
    );
