import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_radio_group.dart';
import 'about_yourself_screen.dart';


class AssetDetailsScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Asset Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRadioGroup(
              label: 'Agriculture Land',
              options: const ['Owned', 'Rented', 'Parental'],
              selectedValue: controller.agricultureLand,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'House/Building',
              options: const ['Owned', 'Rented', 'Parental'],
              selectedValue: controller.houseBuilding,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Commercial Complex',
              options: const ['Owned', 'Rented', 'Parental'],
              selectedValue: controller.commercialComplex,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Two-Wheeler',
              options: const ['Owned', 'Rented', 'Parental'],
              selectedValue: controller.twoWheeler,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Three-Wheeler',
              options: const ['Owned', 'Rented', 'Parental'],
              selectedValue: controller.threeWheeler,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Four-Wheeler',
              options: const ['Owned', 'Rented', 'Parental'],
              selectedValue: controller.fourWheeler,
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
                      if (controller.validateAssets()) {
                        Get.to(() => AboutYourselfScreen());
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
