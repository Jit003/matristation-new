import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/register_screen.dart';
import 'package:matri_station/ui/dashboard_screen.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';

import '../controller/login_controller.dart';
import '../utility/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBarWidget(title: 'LogIn',showBackButton: false,),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Matri',
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

                        const SizedBox(height: 8),
                        Text(
                          "Welcome Back! Sign in to continue",
                          style: GoogleFonts.poppins(
                            color: MatriColors.greyMedium,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 900),
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: _inputDecoration(
                              label: "Email Address",
                              icon: Icons.email_outlined,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!GetUtils.isEmail(value.trim())) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Obx(
                                () => TextFormField(
                              controller: controller.passwordController,
                              obscureText: controller.isPasswordHidden.value,
                              decoration: _inputDecoration(
                                label: "Password",
                                icon: Icons.lock_outline,
                                suffix: controller.isPasswordHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                suffixAction:
                                controller.togglePasswordVisibility,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                                  () => Row(
                                children: [
                                  Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: controller.toggleRememberMe,
                                    activeColor: MatriColors.primaryGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Text(
                                    "Remember Me",
                                    style: GoogleFonts.poppins(
                                      color: MatriColors.greyDark,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.poppins(
                                  color: MatriColors.accentRed,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1100),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: (){
                                Get.to(DashboardScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MatriColors.accentRed,
                                foregroundColor: MatriColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                                shadowColor: MatriColors.accentRed,
                              ),
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: MatriColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: MatriColors.greyLight,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Or sign in with",
                            style: GoogleFonts.poppins(
                              color: MatriColors.greyMedium,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: MatriColors.greyLight,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton(
                          Icons.g_mobiledata,
                          MatriColors.primaryGreen,
                              () {},
                        ),
                        const SizedBox(width: 16),
                        _socialButton(
                          Icons.call,
                          MatriColors.secondaryRed,
                              () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New to Matri-Station?",
                          style: GoogleFonts.poppins(
                            color: MatriColors.greyDark,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const RegisterScreen());
                          },
                          child: Text(
                            "Register Here",
                            style: GoogleFonts.poppins(
                              color: MatriColors.accentRed,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
        );
      },
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    IconData? suffix,
    VoidCallback? suffixAction,
  }) {
    return InputDecoration(
      labelText: label,
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: MatriColors.secondaryRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: MatriColors.secondaryRed, width: 2),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: color,
        elevation: 2,
        shadowColor: color.withOpacity(0.3),
      ),
      child: Icon(icon, color: MatriColors.white, size: 22),
    );
  }
}