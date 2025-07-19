import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/formfillup/partner_preferences_screen.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../../controller/registration_controller.dart';

class AboutYourselfScreen extends StatelessWidget {
  final RegistrationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'About Yourself'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personalise (Edit)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Write a short paragraph describing yourself, your values, interests, and what you\'re looking for in a partner.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: controller.aboutYourselfController,
                maxLines: 8,
                maxLength: 500,
                decoration: const InputDecoration(
                  hintText: 'Tell us about yourself...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  counterText: '',
                ),
              ),
            ),
            const SizedBox(height: 8),

             Text(
              '${controller.aboutYourselfController.text.length}/500 characters',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

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
                      Icon(Icons.lightbulb_outline, color: Colors.green[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Tips for a great profile:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Be genuine and authentic\n'
                        '• Mention your hobbies and interests\n'
                        '• Share your values and what matters to you\n'
                        '• Describe what you\'re looking for in a partner\n'
                        '• Keep it positive and engaging',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green[700],
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
                      if (controller.validateAbout()) {
                        // Final submission
                        Get.to(()=>PartnerPreferencesScreen());
                      } else {
                        Get.snackbar(
                          'Validation Error',
                          'Please write something about yourself',
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

  void _showSubmissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete!'),
          content: const Text(
            'Your profile has been successfully created. You can now start exploring matches and connecting with potential partners.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to home screen or dashboard
                Get.snackbar(
                  'Success',
                  'Registration completed successfully!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
