import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_checkbox.dart';
import '../../widget/custom_radio_group.dart';
import '../../widget/custom_range_slider_widget.dart';
import '../../widget/custom_text_field.dart';
import 'birth_details_screen.dart';

class BasicDetailsScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(title: 'Basic Details',showBackButton: false,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomTextField(
              label: 'Full Name *',
              controller: controller.fullNameController,
              isBold: true,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Gender *',
              options: const ['Male', 'Female', 'Other'],
              selectedValue: controller.selectedGender,
            ),
            const SizedBox(height: 16),

           Obx(()=> CustomSliderWidget(
             title: "Select Height *",
             min: 100,
             max: 220,
             value: controller.height.value,
             unit: "cm",
             onChanged: (val) => controller.height.value = val,
           ),),
            const SizedBox(height: 16),
            Obx(()=>CustomSliderWidget(
              title: "Select Weight *",
              min: 30,
              max: 150,
              value: controller.weight.value,
              unit: "kg",
              onChanged: (val) => controller.weight.value = val,
            ),),
            const SizedBox(height: 16),

            Obx(() => controller.selectedGender.value == 'Male'
                ? Column(
              children: [
                CustomSliderWidget(
                  title: "Select Chest *",
                  min: 100,
                  max: 220,
                  value: controller.chest.value,
                  unit: "kg",
                  onChanged: (val) => controller.chest.value = val,
                ),
                const SizedBox(height: 16),
                CustomSliderWidget(
                  title: "Select Waist *",
                  min: 100,
                  max: 220,
                  value: controller.waist.value,
                  unit: "kg",
                  onChanged: (val) => controller.waist.value = val,
                ),
                const SizedBox(height: 16),
              ],
            )
                : const SizedBox()),

            CustomRadioGroup(
              label: 'Marital Status *',
              options: const ['Never Married', 'Divorced', 'Widowed', 'Separated'],
              selectedValue: controller.selectedMaritalStatus,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'No of Children',
              controller: controller.noOfChildrenController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Children',
              options: const ['Yes living together', 'No', 'Yes, Not living together'],
              selectedValue: controller.hasChildren,
            ),
            const SizedBox(height: 16),

            CustomRadioGroup(
              label: 'Profile Created By *',
              options: const ['Self', 'Parent', 'Sibling', 'Relative', 'Friend'],
              selectedValue: controller.profileCreatedBy,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Blood Group (Optional)',
              controller: controller.bloodGroupController,
            ),
            const SizedBox(height: 16),

            CustomCheckboxGroup(
              label: 'Specs/Lenses',
              value: controller.hasSpecs,
            ),
            const SizedBox(height: 16),

            CustomCheckboxGroup(
              label: 'Any Disability',
              value: controller.hasDisability,
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateBasicDetails()) {
                    Get.to(() => BirthDetailsScreen());
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
      ),
    );
  }
}
