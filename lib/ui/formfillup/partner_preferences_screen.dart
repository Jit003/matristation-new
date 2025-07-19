import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/dashboard_screen.dart';
import 'package:matri_station/ui/subscription/subscription_plan_screen.dart';
import '../../controller/registration_controller.dart';
import '../../widget/custom_app_bar_other_page.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/custom_radio_group.dart';
import '../../widget/custom_text_field.dart';


class PartnerPreferencesScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Partner Preferences'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your matches will be visible based on your preferences',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 1. Basic Details Section
            _buildSectionHeader('1. Basic Details'),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Age From',
                    controller: controller.partnerAgeFromController,
                    keyboardType: TextInputType.number,
                    suffix: 'years',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Age To',
                    controller: controller.partnerAgeToController,
                    keyboardType: TextInputType.number,
                    suffix: 'years',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Height From',
                    controller: controller.partnerHeightFromController,
                    keyboardType: TextInputType.number,
                    suffix: 'cm / ft-in',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Height To',
                    controller: controller.partnerHeightToController,
                    keyboardType: TextInputType.number,
                    suffix: 'cm / ft-in',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildMultiSelectField(
              'Marital Status',
              ['Never Married', 'Divorced', 'Widowed', 'Separated'],
              controller.partnerMaritalStatus,
            ),
            const SizedBox(height: 16),

             CustomRadioGroup(
              label: 'Have Children',
              options: ['Any', 'Yes', 'No'],
              selectedValue: controller.partnerHaveChildren,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Mother Tongue',
              controller: controller.partnerMotherTongueController,
              hint: 'e.g., Hindi, English, Tamil',
            ),
            const SizedBox(height: 16),

             CustomRadioGroup(
              label: 'Physical Status',
              options: ['Any', 'Normal', 'Physically Challenged'],
              selectedValue: controller.partnerPhysicalStatus,
            ),
            const SizedBox(height: 24),

            // 2. Religion & Caste Section
            _buildSectionHeader('2. Religion & Caste'),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Religion',
              controller: controller.partnerReligionController,
              hint: 'e.g., Hindu, Muslim, Christian, Sikh',
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Caste',
              controller: controller.partnerCasteController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Subcaste',
              controller: controller.partnerSubcasteController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Star',
              controller: controller.partnerStarController,
              hint: 'Nakshatra preference',
            ),
            const SizedBox(height: 16),

             CustomRadioGroup(
              label: 'Dosham',
              options: ['Any', 'Yes', 'No', "Don't Know"],
              selectedValue: controller.partnerDosham,
            ),
            const SizedBox(height: 24),

            // 3. Education & Career Section
            _buildSectionHeader('3. Education & Career'),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Education',
              controller: controller.partnerEducationController,
              hint: 'e.g., Graduate, Post Graduate, Professional',
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Employment Type',
              controller: controller.partnerEmploymentTypeController,
              hint: 'e.g., Government, Private, Business, Self-employed',
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Annual Income',
              controller: controller.partnerAnnualIncomeController,
              prefix: '₹',
              keyboardType: TextInputType.number,
              hint: 'Minimum expected income',
            ),
            const SizedBox(height: 24),

            // 4. Location Section
            _buildSectionHeader('4. Location'),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Country',
              controller: controller.partnerCountryController,
              hint: 'Preferred country',
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'State',
              controller: controller.partnerStateController,
              hint: 'Preferred state',
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'City/District Preference',
              controller: controller.partnerCityController,
              hint: 'Preferred cities or districts',
            ),
            const SizedBox(height: 24),

            // 5. Lifestyle & Personal Habits Section
            _buildSectionHeader('5. Lifestyle & Personal Habits'),
            const SizedBox(height: 16),

             CustomRadioGroup(
              label: 'Eating Habit',
              options: ['Any', 'Veg', 'Non-Veg', 'Eggetarian', 'Vegan', 'Jain'],
              selectedValue: controller.partnerEatingHabit,
            ),
            const SizedBox(height: 16),

             CustomRadioGroup(
              label: 'Smoking Habit',
              options: ['Any', 'Yes', 'No'],
              selectedValue: controller.partnerSmokingHabit,
            ),
            const SizedBox(height: 16),

             CustomRadioGroup(
              label: 'Drinking Habit',
              options: ['Any', 'Yes', 'No'],
              selectedValue: controller.partnerDrinkingHabit,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Lifestyle Habits',
              controller: controller.partnerLifestyleHabitsController,
              maxLines: 2,
              hint: 'Any specific lifestyle preferences',
            ),
            const SizedBox(height: 24),

            // 6. Expectations Section
            _buildSectionHeader('6. Expectations'),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Other Expectations',
              controller: controller.partnerOtherExpectationsController,
              maxLines: 3,
              hint: 'Describe any other specific expectations from your partner...',
            ),
            const SizedBox(height: 24),

            // 11. Upload Photo Section
            _buildSectionHeader('11. Upload Photo'),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.camera_alt, color: Colors.orange[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Photo Requirements (Recommended)',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.orange[700],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Upload 10 photos (Minimum 4 required)\n'
                        '• At least one front view\n'
                        '• One rear view\n'
                        '• One side view\n'
                        '• One passport style photo\n'
                        '• One sitting in chair view',
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

             CheckboxListTile(
              title: const Text('Attach Profile Photo (Recommended)'),
              subtitle: Text('${controller.profilePhotos.length}/10 photos uploaded'),
              value: controller.profilePhotos.isNotEmpty,
              onChanged: (value) {
                if (value == true) {
                  _showPhotoUploadDialog(context);
                } else {
                  controller.profilePhotos.clear();
                }
              },
              activeColor: const Color(0xFF4CAF50),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 8),

            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.profilePhotos.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.profilePhotos.length) {
                    return GestureDetector(
                      onTap: () => _showPhotoUploadDialog(context),
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!, width: 2, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, color: Colors.grey[400], size: 32),
                            const SizedBox(height: 4),
                            Text('Add Photo', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF4CAF50), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: NetworkImage(controller.profilePhotos[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => controller.profilePhotos.removeAt(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
                ,
            const SizedBox(height: 16),

             CheckboxListTile(
              title: const Text('Allow only verified users to view my photo'),
              subtitle: const Text('Recommended for privacy'),
              value: controller.allowVerifiedUsersOnly.value,
              onChanged: (value) {
                controller.allowVerifiedUsersOnly.value = value!;
              },
              activeColor: const Color(0xFF4CAF50),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photo Visibility',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                 Row(
                  children: [
                    Radio<String>(
                      value: 'Public',
                      groupValue: controller.photoVisibility.value,
                      onChanged: (value) {
                        controller.photoVisibility.value = value!;
                      },
                      activeColor: const Color(0xFF4CAF50),
                    ),
                    const Text('Public'),
                    const SizedBox(width: 16),
                    Radio<String>(
                      value: 'Private',
                      groupValue: controller.photoVisibility.value,
                      onChanged: (value) {
                        controller.photoVisibility.value = value!;
                      },
                      activeColor: const Color(0xFF4CAF50),
                    ),
                    const Text('Private'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 12. Verification Section
            _buildSectionHeader('12. Verification (Optional)'),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_user, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Verification (Optional)',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Verify your profile to gain more trust and get better matches.',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

             CustomRadioGroup(
              label: 'Document Type',
              options: ['Select Document', 'Aadhaar', 'PAN', 'Passport', 'Voter ID'],
              selectedValue: controller.selectedDocumentType,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Aadhaar / PAN / Passport No. / Voter ID',
              controller: controller.verificationDocumentController,
              hint: 'Enter your document number',
            ),
            const SizedBox(height: 16),

             CheckboxListTile(
              title: const Text('Verified Badge Needed?'),
              subtitle: const Text('Show verified badge on your profile'),
              value: controller.verifiedBadgeNeeded.value,
              onChanged: (value) {
                controller.verifiedBadgeNeeded.value = value!;
              },
              activeColor: const Color(0xFF4CAF50),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: Colors.green[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Benefits of Verification',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Increased profile visibility\n'
                        '• Higher trust from other members\n'
                        '• Access to verified members only\n'
                        '• Priority in search results\n'
                        '• Verified badge on your profile',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
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
                      Get.to(()=>SubscriptionScreen());
                    },
                    child: const Text('SUBMIT'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4CAF50),
      ),
    );
  }

  Widget _buildMultiSelectField(String label, List<String> options, RxList<String> selectedValues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
         Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedValues.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  selectedValues.add(option);
                } else {
                  selectedValues.remove(option);
                }
              },
              selectedColor: const Color(0xFF4CAF50).withOpacity(0.2),
              checkmarkColor: const Color(0xFF4CAF50),
              backgroundColor: Colors.grey[100],
              side: BorderSide(
                color: isSelected ? const Color(0xFF4CAF50) : Colors.grey[300]!,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showPhotoUploadDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _addPhoto('camera');
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _addPhoto('gallery');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addPhoto(String source) {
    if (controller.profilePhotos.length < 10) {
      controller.profilePhotos.add('/placeholder.svg?height=200&width=200&text=Photo${controller.profilePhotos.length + 1}');
    } else {
      Get.snackbar(
        'Limit Reached',
        'You can upload maximum 10 photos',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600], size: 28),
              const SizedBox(width: 8),
              const Text('Registration Complete!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Congratulations! Your matrimonial profile has been successfully created with all preferences.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What\'s Next?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Browse and connect with matches\n'
                          '• Complete verification for better visibility\n'
                          '• Update your preferences anytime\n'
                          '• Start your journey to find your perfect partner',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.snackbar(
                  'Welcome!',
                  'Your profile is now live. Start exploring matches!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 3),
                );
                // Navigate to main app or dashboard
              },
              child: const Text('Start Exploring'),
            ),
          ],
        );
      },
    );
  }
}
