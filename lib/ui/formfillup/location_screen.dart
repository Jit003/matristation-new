import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/formfillup/education_carrer_screen.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_checkbox.dart';
import '../../widget/custom_text_field.dart';


class LocationScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Location Details'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Country *',
              controller: controller.countryController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'State *',
              controller: controller.stateController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'City / District *',
              controller: controller.cityController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'PIN',
              controller: controller.pinController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Citizenship',
              controller: controller.citizenshipController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Present Address (Google Mapping)',
              controller: controller.presentAddressController,
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            CustomCheckboxGroup(
              label: 'Willingness to move abroad or relocate',
              value: controller.willingnessToRelocate,
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
                      if (controller.validateLocation()) {
                        // Here you can call API to submit the form
                      Get.to(()=>EducationCareerScreen());
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
