import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../../controller/my_profile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  final MyProfileController controller = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBarWidget(title: 'My Profile'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildPhotoSlider(),
              SizedBox(height: 16),
              _buildQuickActions(),
              SizedBox(height: 16),
              _buildAboutSection(),
              SizedBox(height: 16),
              _buildBasicDetails(),
              SizedBox(height: 16),
              _buildEducationCareer(),
              SizedBox(height: 16),
              _buildFamilyDetails(),
              SizedBox(height: 16),
              _buildLocationDetails(),
              SizedBox(height: 16),
              _buildLifestyle(),
              SizedBox(height: 16),
              _buildPartnerPreferences(),
              SizedBox(height: 100),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF4CAF50),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'My Profile',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Get.snackbar(
              'Settings',
              'Profile settings coming soon...',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color(0xFF4CAF50),
              colorText: Colors.white,
            );
          },
        ),
      ],
    );
  }

  Widget _buildPhotoSlider() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          // Main photo slider
          Obx(() => PageView.builder(
            itemCount: controller.profileImages.length,
            onPageChanged: controller.changeImage,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: controller.openImageGallery,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      controller.profileImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          )),

          // Photo indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.profileImages.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.currentImageIndex.value == entry.key
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            )),
          ),

          // Edit photo button
          Positioned(
            top: 16,
            right: 32,
            child: GestureDetector(
              onTap: controller.openImageGallery,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionCard(
              icon: Icons.photo_library,
              title: 'Photos',
              subtitle: '${controller.profileImages.length} photos',
              onTap: controller.openImageGallery,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildActionCard(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'Edit email',
              onTap: controller.editEmail,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildActionCard(
              icon: Icons.phone,
              title: 'Contact',
              subtitle: 'Edit phone',
              onTap: controller.editPhone,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildActionCard(
              icon: Icons.stars,
              title: 'Horoscope',
              subtitle: 'View & edit',
              onTap: controller.editHoroscope,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Color(0xFF4CAF50),
                size: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'About Me',
      icon: Icons.person_outline,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.myProfile.value.about,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: controller.editAbout,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF4CAF50).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit,
                    size: 14,
                    color: Color(0xFF4CAF50),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Edit About',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildBasicDetails() {
    return Obx(() => _buildSection(
      title: 'Basic Details',
      icon: Icons.info_outline,
      child: Column(
        children: [
          _buildDetailRow('Height', controller.myProfile.value.basicDetails.height),
          _buildDetailRow('Weight', controller.myProfile.value.basicDetails.weight),
          _buildDetailRow('Marital Status', controller.myProfile.value.basicDetails.maritalStatus),
          _buildDetailRow('Mother Tongue', controller.myProfile.value.basicDetails.motherTongue),
          _buildDetailRow('Religion', controller.myProfile.value.basicDetails.religion),
          _buildDetailRow('Caste', controller.myProfile.value.basicDetails.caste),
          _buildDetailRow('Date of Birth', controller.myProfile.value.basicDetails.dateOfBirth),
          _buildDetailRow('Time of Birth', controller.myProfile.value.basicDetails.timeOfBirth),
          _buildDetailRow('Place of Birth', controller.myProfile.value.basicDetails.placeOfBirth),
        ],
      ),
      onEdit: () => controller.editSection('Basic Details'),
    ));
  }

  Widget _buildEducationCareer() {
    return Obx(() => _buildSection(
      title: 'Education & Career',
      icon: Icons.school_outlined,
      child: Column(
        children: [
          _buildDetailRow('Education', controller.myProfile.value.educationCareer.education),
          _buildDetailRow('Occupation', controller.myProfile.value.educationCareer.occupation),
          _buildDetailRow('Employed In', controller.myProfile.value.educationCareer.employedIn),
          _buildDetailRow('Annual Income', controller.myProfile.value.educationCareer.annualIncome),
          _buildDetailRow('Work Location', controller.myProfile.value.educationCareer.workLocation),
        ],
      ),
      onEdit: () => controller.editSection('Education & Career'),
    ));
  }

  Widget _buildFamilyDetails() {
    return Obx(() => _buildSection(
      title: 'Family Details',
      icon: Icons.family_restroom,
      child: Column(
        children: [
          _buildDetailRow('Father\'s Name', controller.myProfile.value.familyDetails.fatherName),
          _buildDetailRow('Father\'s Occupation', controller.myProfile.value.familyDetails.fatherOccupation),
          _buildDetailRow('Mother\'s Name', controller.myProfile.value.familyDetails.motherName),
          _buildDetailRow('Mother\'s Occupation', controller.myProfile.value.familyDetails.motherOccupation),
          _buildDetailRow('Siblings', controller.myProfile.value.familyDetails.siblings),
          _buildDetailRow('Family Type', controller.myProfile.value.familyDetails.familyType),
          _buildDetailRow('Family Values', controller.myProfile.value.familyDetails.familyValues),
        ],
      ),
      onEdit: () => controller.editSection('Family Details'),
    ));
  }

  Widget _buildLocationDetails() {
    return Obx(() => _buildSection(
      title: 'Location Details',
      icon: Icons.location_on_outlined,
      child: Column(
        children: [
          _buildDetailRow('Country', controller.myProfile.value.locationDetails.country),
          _buildDetailRow('State', controller.myProfile.value.locationDetails.state),
          _buildDetailRow('City', controller.myProfile.value.locationDetails.city),
          _buildDetailRow('Address', controller.myProfile.value.locationDetails.address),
          _buildDetailRow('Residency Status', controller.myProfile.value.locationDetails.residencyStatus),
        ],
      ),
      onEdit: () => controller.editSection('Location Details'),
    ));
  }

  Widget _buildLifestyle() {
    return Obx(() => _buildSection(
      title: 'Lifestyle',
      icon: Icons.abc,
      child: Column(
        children: [
          _buildDetailRow('Diet', controller.myProfile.value.lifestyle.diet),
          _buildDetailRow('Smoking', controller.myProfile.value.lifestyle.smoking),
          _buildDetailRow('Drinking', controller.myProfile.value.lifestyle.drinking),
          _buildDetailRow('Hobbies', controller.myProfile.value.lifestyle.hobbies),
        ],
      ),
      onEdit: () => controller.editSection('Lifestyle'),
    ));
  }

  Widget _buildPartnerPreferences() {
    return Obx(() => _buildSection(
      title: 'Partner Preferences',
      icon: Icons.favorite_outline,
      child: Column(
        children: [
          _buildDetailRow('Age Range', controller.myProfile.value.partnerPreferences.ageRange),
          _buildDetailRow('Height Range', controller.myProfile.value.partnerPreferences.heightRange),
          _buildDetailRow('Marital Status', controller.myProfile.value.partnerPreferences.maritalStatus),
          _buildDetailRow('Education', controller.myProfile.value.partnerPreferences.education),
          _buildDetailRow('Occupation', controller.myProfile.value.partnerPreferences.occupation),
          _buildDetailRow('Location', controller.myProfile.value.partnerPreferences.location),
          _buildDetailRow('Diet', controller.myProfile.value.partnerPreferences.diet),
          _buildDetailRow('Smoking', controller.myProfile.value.partnerPreferences.smoking),
          _buildDetailRow('Drinking', controller.myProfile.value.partnerPreferences.drinking),
        ],
      ),
      onEdit: () => controller.editSection('Partner Preferences'),
    ));
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
    VoidCallback? onEdit,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: Color(0xFF4CAF50),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              if (onEdit != null)
                GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Color(0xFF4CAF50),
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not specified' : value,
              style: TextStyle(
                fontSize: 14,
                color: value.isEmpty ? Colors.grey[400] : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
