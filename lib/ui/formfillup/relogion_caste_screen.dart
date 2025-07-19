import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_text_field.dart';
import 'location_screen.dart';

class ReligionCasteScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Religion Details'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Religion *',
              controller: controller.religionController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Caste *',
              controller: controller.casteController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Sub Caste',
              controller: controller.subCasteController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Gothra (Optional)',
              controller: controller.gothraController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Mother Tongue *',
              controller: controller.motherTongueController,
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
                      if (controller.validateReligionCaste()) {
                        Get.to(() => LocationScreen());
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
