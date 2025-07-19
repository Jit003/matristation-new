import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_checkbox.dart';
import '../../widget/custom_radio_group.dart';
import '../../widget/custom_text_field.dart';
import 'asset_details_screen.dart';


class LifestyleScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Lifestyle Details'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRadioGroup(
              label: 'Body Type *',
              options: const ['Slim', 'Average', 'Athletic', 'Heavy'],
              selectedValue: controller.bodyType,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Complexion *',
              options: const ['Very Fair', 'Fair', 'Wheatish', 'Dark'],
              selectedValue: controller.complexion,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Eating Habit *',
              options: const ['Veg', 'Non-Veg', 'Eggetarian', 'Vegan', 'Jain'],
              selectedValue: controller.eatingHabit,
            ),
            const SizedBox(height: 16),

            CustomCheckboxGroup(
              label: 'Smoke Habit',
              value: controller.smokeHabit,
            ),
            const SizedBox(height: 16),

            CustomCheckboxGroup(
              label: 'Drink Habit',
              value: controller.drinkHabit,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Hobbies',
              controller: controller.hobbiesController,
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Interests',
              controller: controller.interestsController,
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Languages Known',
              controller: controller.languagesKnownController,
              hint: 'e.g., English, Hindi, Tamil',
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
                      if (controller.validateLifestyle()) {
                        Get.to(() => AssetDetailsScreen());
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
