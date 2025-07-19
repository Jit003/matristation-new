import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/formfillup/relogion_caste_screen.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_checkbox.dart';
import '../../widget/custom_text_field.dart';


class ContactDetailsScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Contact Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Mobile Number *',
              controller: controller.mobileController,
              prefix: '+91',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Alternate Mobile (Optional)',
              controller: controller.alternateMobileController,
              prefix: '+91',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Email Address *',
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            CustomCheckboxGroup(
              label: 'WhatsApp Available',
              value: controller.hasWhatsApp,
            ),
            const SizedBox(height: 16),

            CustomCheckboxGroup(
              label: 'Verified via OTP?',
              value: controller.isVerifiedOTP,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Facebook ID',
              controller: controller.facebookIdController,
            ),
            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text('BACK'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.validateContactDetails()) {
                        Get.to(() => ReligionCasteScreen());
                      } else {
                        Get.snackbar(
                          'Validation Error',
                          'Please fill all required fields',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: const Text('NEXT'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
