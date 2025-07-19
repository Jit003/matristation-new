import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/dashboard_screen.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var rememberMe = false.obs;

  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    if (formKey.currentState!.validate()) {
     Get.to(()=>DashboardScreen());
    }
  }
}