import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_radio_group.dart';
import '../../widget/custom_text_field.dart';
import 'lifestyle_personal_habits_screen.dart';


class FamilyDetailsScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Family Details'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: "Father's Name *",
              controller: controller.fatherNameController,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: "Father's Occupation",
              options: const ['Employed', 'Businessman', 'Retired', 'Homemaker', 'Passed away'],
              selectedValue: controller.fatherOccupation,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: "Mother's Name *",
              controller: controller.motherNameController,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: "Mother's Occupation",
              options: const ['Employed', 'Businessman', 'Retired', 'Homemaker', 'Passed away'],
              selectedValue: controller.motherOccupation,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'No. of Brothers',
                    controller: controller.noOfBrothersController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Row(
                        children: [
                          Radio<String>(
                            value: 'Married',
                            groupValue: controller.brothersMaritalStatus.value,
                            onChanged: (value) {
                              controller.brothersMaritalStatus.value = value!;
                            },
                            activeColor: const Color(0xFF4CAF50),
                          ),
                          const Text('Married'),
                          Radio<String>(
                            value: 'Unmarried',
                            groupValue: controller.brothersMaritalStatus.value,
                            onChanged: (value) {
                              controller.brothersMaritalStatus.value = value!;
                            },
                            activeColor: const Color(0xFF4CAF50),
                          ),
                          const Text('Unmarried'),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'No. of Sisters',
                    controller: controller.noOfSistersController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Row(
                        children: [
                          Radio<String>(
                            value: 'Married',
                            groupValue: controller.sistersMaritalStatus.value,
                            onChanged: (value) {
                              controller.sistersMaritalStatus.value = value!;
                            },
                            activeColor: const Color(0xFF4CAF50),
                          ),
                          const Text('Married'),
                          Radio<String>(
                            value: 'Unmarried',
                            groupValue: controller.sistersMaritalStatus.value,
                            onChanged: (value) {
                              controller.sistersMaritalStatus.value = value!;
                            },
                            activeColor: const Color(0xFF4CAF50),
                          ),
                          const Text('Unmarried'),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Family Type *',
              options: const ['Joint', 'Nuclear'],
              selectedValue: controller.familyType,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Family Values *',
              options: const ['Traditional', 'Moderate', 'Liberal'],
              selectedValue: controller.familyValues,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Family Income (Optional)',
              controller: controller.familyIncomeController,
              prefix: '₹',
              keyboardType: TextInputType.number,
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
                      if (controller.validateFamilyDetails()) {
                        Get.to(() => LifestyleScreen());
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
