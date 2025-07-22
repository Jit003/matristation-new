import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:matri_station/ui/formfillup/basic_details_screen.dart';

class OtpController extends GetxController {
  // Loading states
  var isLoading = false.obs;
  var isResending = false.obs;
  var isVerifying = false.obs;

  // OTP data
  var otpCode = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var verificationType = 'phone'.obs; // 'phone' or 'email'

  // Timer for resend functionality
  var resendTimer = 0.obs;
  Timer? _timer;

  // OTP input controllers
  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  // Form validation
  var isOtpComplete = false.obs;
  var otpError = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Get arguments from navigation
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      phoneNumber.value = args['phoneNumber'] ?? '';
      email.value = args['email'] ?? '';
      verificationType.value = args['type'] ?? 'phone';
    }

    // Start resend timer
    startResendTimer();

    // Add listeners to OTP controllers
    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(() => onOtpChanged(i));
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void onOtpChanged(int index) {
    String value = otpControllers[index].text;

    // Move to next field if current field has value
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    // Move to previous field if current field is empty and backspace is pressed
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    // Update OTP code
    updateOtpCode();

    // Clear error when user starts typing
    if (otpError.value.isNotEmpty) {
      otpError.value = '';
    }
  }

  void updateOtpCode() {
    String code = '';
    for (var controller in otpControllers) {
      code += controller.text;
    }
    otpCode.value = code;
    isOtpComplete.value = code.length == 6;

    // Auto-verify when OTP is complete
    if (isOtpComplete.value) {
      Future.delayed(Duration(milliseconds: 500), () {
        verifyOtp();
      });
    }
  }

  void onOtpFieldTap(int index) {
    // Focus on the first empty field or the tapped field
    for (int i = 0; i < otpControllers.length; i++) {
      if (otpControllers[i].text.isEmpty) {
        focusNodes[i].requestFocus();
        return;
      }
    }
    focusNodes[index].requestFocus();
  }

  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    otpCode.value = '';
    isOtpComplete.value = false;
    otpError.value = '';
    focusNodes[0].requestFocus();
  }

  void startResendTimer() {
    resendTimer.value = 60; // 60 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    if (resendTimer.value > 0) return;

    isResending.value = true;
    otpError.value = '';

    try {
      // Simulate API call for resending OTP
      await Future.delayed(Duration(seconds: 2));

      // API call would be something like:
      // final response = await ApiService.resendOtp(
      //   phoneNumber: phoneNumber.value,
      //   email: email.value,
      //   type: verificationType.value,
      // );

      // Simulate success response
      bool success = true; // This would come from API response

      if (success) {
        startResendTimer();
        clearOtp();

        Get.snackbar(
          'OTP Sent',
          'A new OTP has been sent to your ${verificationType.value}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xFF4CAF50),
          colorText: Colors.white,
          icon: Icon(Icons.check_circle, color: Colors.white),
          duration: Duration(seconds: 3),
        );
      } else {
        throw Exception('Failed to resend OTP');
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Icons.error, color: Colors.white),
        duration: Duration(seconds: 3),
      );
    } finally {
      isResending.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (!isOtpComplete.value) {
      otpError.value = 'Please enter complete OTP';
      return;
    }

    isVerifying.value = true;
    otpError.value = '';

    try {
      // Simulate API call for OTP verification
      await Future.delayed(Duration(seconds: 2));

      // API call would be something like:
      // final response = await ApiService.verifyOtp(
      //   phoneNumber: phoneNumber.value,
      //   email: email.value,
      //   otp: otpCode.value,
      //   type: verificationType.value,
      // );

      // Simulate API response
      Map<String, dynamic> response = {
        'success': otpCode.value == '123456', // For demo, accept 123456
        'message': otpCode.value == '123456' ? 'OTP verified successfully' : 'Invalid OTP',
        'token': otpCode.value == '123456' ? 'sample_jwt_token_here' : null,
        'user': otpCode.value == '123456' ? {
          'id': '12345',
          'name': 'John Doe',
          'phone': phoneNumber.value,
          'email': email.value,
        } : null,
      };

      if (response['success']) {
        // Store token and user data (you might want to use GetStorage or SharedPreferences)
        // await StorageService.saveToken(response['token']);
        // await StorageService.saveUser(response['user']);

        Get.snackbar(
          'Success',
          response['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xFF4CAF50),
          colorText: Colors.white,
          icon: Icon(Icons.check_circle, color: Colors.white),
          duration: Duration(seconds: 2),
        );

        // Navigate to next screen after short delay
        Future.delayed(Duration(seconds: 1), () {
          Get.to(()=>BasicDetailsScreen()); // Replace with your home route
        });

      } else {
        otpError.value = response['message'];

        // Shake animation for wrong OTP
        _shakeOtpFields();
      }

    } catch (e) {
      otpError.value = 'Verification failed. Please try again.';
      _shakeOtpFields();
    } finally {
      isVerifying.value = false;
    }
  }

  void _shakeOtpFields() {
    // This would trigger a shake animation
    // You can implement this with AnimationController if needed
    clearOtp();
  }

  void changeVerificationMethod() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.swap_horiz,
                color: Color(0xFF4CAF50),
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'Change Verification Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Choose how you want to receive the OTP',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              if (phoneNumber.value.isNotEmpty)
                _buildMethodOption(
                  icon: Icons.phone,
                  title: 'Phone Number',
                  subtitle: _maskPhoneNumber(phoneNumber.value),
                  isSelected: verificationType.value == 'phone',
                  onTap: () {
                    verificationType.value = 'phone';
                    Get.back();
                    resendOtp();
                  },
                ),
              if (phoneNumber.value.isNotEmpty && email.value.isNotEmpty)
                SizedBox(height: 12),
              if (email.value.isNotEmpty)
                _buildMethodOption(
                  icon: Icons.email,
                  title: 'Email Address',
                  subtitle: _maskEmail(email.value),
                  isSelected: verificationType.value == 'email',
                  onTap: () {
                    verificationType.value = 'email';
                    Get.back();
                    resendOtp();
                  },
                ),
              SizedBox(height: 24),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF4CAF50) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF4CAF50) : Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Color(0xFF4CAF50) : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  String _maskPhoneNumber(String phone) {
    if (phone.length < 4) return phone;
    return '${phone.substring(0, 3)}****${phone.substring(phone.length - 2)}';
  }

  String _maskEmail(String email) {
    if (!email.contains('@')) return email;
    List<String> parts = email.split('@');
    String username = parts[0];
    String domain = parts[1];

    if (username.length <= 2) return email;
    return '${username.substring(0, 2)}****@$domain';
  }

  String get maskedContact {
    if (verificationType.value == 'phone') {
      return _maskPhoneNumber(phoneNumber.value);
    } else {
      return _maskEmail(email.value);
    }
  }

  String get contactType {
    return verificationType.value == 'phone' ? 'phone number' : 'email address';
  }

  void goBack() {
    Get.back();
  }
}
