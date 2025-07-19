import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_radio_group.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/date_picker_widget.dart';
import 'contact_details_screen.dart';

class BirthDetailsScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Birth Details'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => CustomDatePicker(
              label: "Date of Birth",
              selectedDate: controller.selectedBirthDate.value,
              onDateSelected: controller.setDateOfBirth,
            )),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Age (Auto-Calculated)',
              controller: controller.ageController,
              suffix: 'years',
              enabled: false,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Birth Place *',
              controller: controller.birthPlaceController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Nakshatra / Star',
              controller: controller.nakshatraController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Rasi / Moon Sign (Optional)',
              controller: controller.rasiController,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Manglik *',
              options: const ['Yes', 'No', "Don't Know"],
              selectedValue: controller.isManglik,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Horoscope Privacy Setting',
              options: const ['Visible to all members'],
              selectedValue: controller.horoscopePrivacy,
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
                      if (controller.validateBirthDetails()) {
                        Get.to(() => ContactDetailsScreen());
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
