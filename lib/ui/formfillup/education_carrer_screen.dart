import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_radio_group.dart';
import '../../widget/custom_text_field.dart';
import 'family_details_screen.dart';
class EducationCareerScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Education Details'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Highest Qualification *',
              controller: controller.highestQualificationController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Institution Name *',
              controller: controller.institutionNameController,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Additional Degrees',
                    controller: controller.additionalDegreesController,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    // Add another degree functionality
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add another'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Employed In *',
              options: const ['Govt.', 'Private', 'Business', 'Not Working'],
              selectedValue: controller.employedIn,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Organization',
              controller: controller.organizationController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Designation',
              controller: controller.designationController,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Currency Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => DropdownButtonFormField<String>(
                        value: controller.currencyType.value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        items: ['INR', 'USD', 'EUR', 'GBP'].map((currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.currencyType.value = value!;
                        },
                      )),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    label: 'Annual Income',
                    controller: controller.annualIncomeController,
                    keyboardType: TextInputType.number,
                    prefix: '₹',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Obx(() => CheckboxListTile(
              title: const Text('Keep this private'),
              subtitle: const Text('Income will not be visible to others'),
              value: controller.keepIncomePrivate.value,
              onChanged: (value) {
                controller.keepIncomePrivate.value = value!;
              },
              activeColor: const Color(0xFF4CAF50),
              controlAffinity: ListTileControlAffinity.leading,
            )),
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
                      if (controller.validateEducationCareer()) {
                        Get.to(() => FamilyDetailsScreen());
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
