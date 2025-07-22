import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(title: 'Verify OTP'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      _buildHeader(),
                      SizedBox(height: 40),
                      _buildOtpInput(),
                      _buildErrorMessage(),
                      SizedBox(height: 32),
                      _buildResendSection(),
                      _buildChangeMethodButton(),
                    ],
                  ),
                ),
              ),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Column(
      children: [
        // OTP Icon with animation
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4CAF50),
                Color(0xFF45a049),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF4CAF50).withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.security,
            color: Colors.white,
            size: 60,
          ),
        ),

        SizedBox(height: 32),

        // Title
        Text(
          'Verification Code',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        SizedBox(height: 12),

        // Subtitle
        Obx(() => RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            children: [
              TextSpan(text: 'We have sent a verification code to your\n'),
              TextSpan(
                text: controller.maskedContact,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildOtpInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) => _buildOtpField(index)),
    );
  }

  Widget _buildOtpField(int index) {
    return Obx(() => GestureDetector(
      onTap: () => controller.onOtpFieldTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 50,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: controller.otpError.value.isNotEmpty
                ? Colors.red
                : controller.otpControllers[index].text.isNotEmpty
                ? Color(0xFF4CAF50)
                : Colors.grey[300]!,
            width: controller.otpControllers[index].text.isNotEmpty ? 2 : 1,
          ),
          boxShadow: controller.otpControllers[index].text.isNotEmpty
              ? [
            BoxShadow(
              color: Color(0xFF4CAF50).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: TextField(
          controller: controller.otpControllers[index],
          focusNode: controller.focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.length > 1) {
              controller.otpControllers[index].text = value.substring(0, 1);
            }
          },
        ),
      ),
    ));
  }

  Widget _buildErrorMessage() {
    return Obx(() => AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: controller.otpError.value.isNotEmpty ? 40 : 0,
      child: controller.otpError.value.isNotEmpty
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              controller.otpError.value,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : SizedBox.shrink(),
    ));
  }

  Widget _buildResendSection() {
    return Obx(() => Column(
      children: [
        if (controller.resendTimer.value > 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time,
                color: Colors.grey[500],
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Resend code in ${controller.resendTimer.value}s',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ] else ...[
          Text(
            'Didn\'t receive the code?',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: controller.isResending.value ? null : controller.resendOtp,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFF4CAF50).withOpacity(0.3),
                ),
              ),
              child: controller.isResending.value
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Color(0xFF4CAF50),
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Sending...',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
                  : Text(
                'Resend Code',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    ));
  }

  Widget _buildChangeMethodButton() {
    return Obx(() => (controller.phoneNumber.value.isNotEmpty && controller.email.value.isNotEmpty)
        ? GestureDetector(
      onTap: controller.changeVerificationMethod,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.swap_horiz,
              color: Colors.grey[600],
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Use ${controller.verificationType.value == 'phone' ? 'email' : 'phone'} instead',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    )
        : SizedBox.shrink());
  }

  Widget _buildVerifyButton() {
    return Obx(() => Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.isVerifying.value || !controller.isOtpComplete.value
            ? null
            : controller.verifyOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: controller.isOtpComplete.value ? 4 : 0,
          shadowColor: Color(0xFF4CAF50).withOpacity(0.3),
        ),
        child: controller.isVerifying.value
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Verifying...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
            : Text(
          'Verify & Continue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
