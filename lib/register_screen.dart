import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:matri_station/ui/formfillup/basic_details_screen.dart';
import 'package:matri_station/ui/login_screen.dart';
import 'package:matri_station/ui/otp_screen.dart';
import 'package:matri_station/utility/constant.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';

import 'controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBarWidget(title: 'Create Account'),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Matri-',
                              style: GoogleFonts.poppins(
                                color: Colors.pink, // Pink for 'Matri'
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                            TextSpan(
                              text: 'Station',
                              style: GoogleFonts.poppins(
                                color: Colors.black, // Black for 'Station'
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeInUp(
                      duration: const Duration(milliseconds: 900),
                      child: Text(
                        'Create your account to start your journey',
                        style: GoogleFonts.poppins(
                          color: MatriColors.greyMedium,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: TextField(
                        controller: controller.emailController,
                        decoration: _inputDecoration(
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1100),
                      child: TextField(
                        controller: controller.phoneController,
                        decoration: _inputDecoration(
                          label: 'Phone Number',
                          icon: Icons.phone_outlined,
                          prefixText: '+91 ',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Obx(
                        () => TextField(
                          controller: controller.passwordController,
                          obscureText: controller.obscurePassword.value,
                          decoration: _inputDecoration(
                            label: 'Password',
                            icon: Icons.lock_outline,
                            suffix: controller.obscurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            suffixAction: controller.togglePasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: Obx(
                        () => TextField(
                          controller: controller.confirmPasswordController,
                          obscureText: controller.obscureConfirmPassword.value,
                          decoration: _inputDecoration(
                            label: 'Confirm Password',
                            icon: Icons.lock_outline,
                            suffix: controller.obscureConfirmPassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            suffixAction:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => OtpScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MatriColors.accentRed,
                          foregroundColor: MatriColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: MatriColors.primaryShadow,
                        ),
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MatriColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: GoogleFonts.poppins(
                              color: MatriColors.greyDark,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.poppins(
                                color: MatriColors.accentRed,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? prefixText,
    IconData? suffix,
    VoidCallback? suffixAction,
  }) {
    return InputDecoration(
      labelText: label,
      prefixText: prefixText,
      labelStyle: GoogleFonts.poppins(
        color: MatriColors.greyMedium,
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: MatriColors.primaryGreen, size: 22),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix, color: MatriColors.greyMedium, size: 22),
              onPressed: suffixAction,
            )
          : null,
      filled: true,
      fillColor: MatriColors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: MatriColors.greyLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: MatriColors.primaryGreen, width: 2),
      ),
    );
  }
}
