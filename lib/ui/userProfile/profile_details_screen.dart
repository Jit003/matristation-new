import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_profile_controller.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final ProfileDetailsController controller = Get.put(ProfileDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
          );
        }

        return CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildProfileHeader(),
                  SizedBox(height: 16),
                  _buildActionButtons(),
                  SizedBox(height: 16),
                  _buildBioSection(),
                  SizedBox(height: 16),
                  _buildPersonalDetails(),
                  SizedBox(height: 16),
                  _buildFamilyDetails(),
                  SizedBox(height: 16),
                  _buildReligiousDetails(),
                  SizedBox(height: 16),
                  _buildProfessionalDetails(),
                  SizedBox(height: 16),
                  _buildPartnerPreferences(),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: Color(0xFF4CAF50),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: Colors.white),
          onPressed: controller.shareProfile,
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) {
            if (value == 'report') {
              controller.reportProfile();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'report',
              child: Row(
                children: [
                  Icon(Icons.report, color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text('Report Profile'),
                ],
              ),
            ),
          ],
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _buildImageGallery(),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Obx(() => Stack(
      children: [
        PageView.builder(
          itemCount: controller.profileImages.length,
          onPageChanged: controller.changeImage,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(controller.profileImages[index]),
                  fit: BoxFit.cover,
                  onError: (error, stackTrace) {},
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Image indicators
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
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
          ),
        ),

        // Online status
        if (controller.profile.value?.isOnline == true)
          Positioned(
            top: 100,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'ONLINE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ));
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: EdgeInsets.all(16),
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
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          controller.profile.value?.name ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 8),
                        if (controller.profile.value?.isPremium == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'PREMIUM',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${controller.profile.value?.age} years old',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Quick info
          Row(
            children: [
              _buildQuickInfo(Icons.height, controller.profile.value?.height ?? ''),
              SizedBox(width: 20),
              _buildQuickInfo(Icons.location_on, controller.profile.value?.address?.split(',').first ?? ''),
              SizedBox(width: 20),
            ],
          ),
        ],
      )),
    );
  }

  Widget _buildQuickInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Color(0xFF4CAF50),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => ElevatedButton.icon(
              onPressed: controller.toggleLike,
              icon: Icon(
                controller.isLiked.value ? Icons.favorite : Icons.favorite_border,
                size: 20,
              ),
              label: Text('Interest'),
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isLiked.value ? Colors.red : Colors.white,
                foregroundColor: controller.isLiked.value ? Colors.white : Colors.red,
                side: BorderSide(color: Colors.red),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: controller.sendMessage,
              icon: Icon(Icons.chat_bubble_outline, size: 20),
              label: Text('Message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Obx(() => IconButton(
            onPressed: controller.toggleShortlist,
            icon: Icon(
              controller.isShortlisted.value ? Icons.bookmark : Icons.bookmark_border,
              color: controller.isShortlisted.value ? Color(0xFF4CAF50) : Colors.grey[600],
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Obx(() {
      final bio = controller.profileDetails.value?.bio ?? '';
      if (bio.isEmpty) return SizedBox.shrink();

      return _buildSection(
        'About',
        Icons.person_outline,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.showFullBio.value || bio.length <= 150
                  ? bio
                  : '${bio.substring(0, 150)}...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            if (bio.length > 150)
              GestureDetector(
                onTap: controller.toggleBio,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    controller.showFullBio.value ? 'Show Less' : 'Read More',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildPersonalDetails() {
    return Obx(() {
      final details = controller.profileDetails.value?.personalDetails;
      if (details == null) return SizedBox.shrink();

      return _buildSection(
        'Personal Details',
        Icons.person,
        Column(
          children: [
            _buildDetailRow('Marital Status', details.maritalStatus),
            _buildDetailRow('Height', details.height),
            _buildDetailRow('Weight', details.weight),
            _buildDetailRow('Body Type', details.bodyType),
            _buildDetailRow('Complexion', details.complexion),
            _buildDetailRow('Physical Status', details.physicalStatus),
            _buildDetailRow('Eating Habits', details.eatingHabits),
            _buildDetailRow('Drinking Habits', details.drinkingHabits),
            _buildDetailRow('Smoking Habits', details.smokingHabits),
          ],
        ),
      );
    });
  }

  Widget _buildFamilyDetails() {
    return Obx(() {
      final details = controller.profileDetails.value?.familyDetails;
      if (details == null) return SizedBox.shrink();

      return _buildSection(
        'Family Details',
        Icons.family_restroom,
        Column(
          children: [
            _buildDetailRow('Father\'s Occupation', details.fatherOccupation),
            _buildDetailRow('Mother\'s Occupation', details.motherOccupation),
            _buildDetailRow('Siblings', details.siblings),
            _buildDetailRow('Family Type', details.familyType),
            _buildDetailRow('Family Values', details.familyValues),
          ],
        ),
      );
    });
  }

  Widget _buildReligiousDetails() {
    return Obx(() {
      final details = controller.profileDetails.value?.religiousDetails;
      if (details == null) return SizedBox.shrink();

      return _buildSection(
        'Religious Details',
        Icons.account_balance,
        Column(
          children: [
            _buildDetailRow('Religion', details.religion),
            _buildDetailRow('Caste', details.caste),
            _buildDetailRow('Sub Caste', details.subCaste),
            _buildDetailRow('Mother Tongue', details.motherTongue),
            _buildDetailRow('Gothra', details.gothra),
          ],
        ),
      );
    });
  }

  Widget _buildProfessionalDetails() {
    return Obx(() {
      final details = controller.profileDetails.value?.professionalDetails;
      if (details == null) return SizedBox.shrink();

      return _buildSection(
        'Professional Details',
        Icons.work,
        Column(
          children: [
            _buildDetailRow('Education', details.education),
            _buildDetailRow('Occupation', details.occupation),
            _buildDetailRow('Employed In', details.employedIn),
            _buildDetailRow('Annual Income', details.annualIncome),
            _buildDetailRow('Work Location', details.workLocation),
          ],
        ),
      );
    });
  }


  Widget _buildPartnerPreferences() {
    return Obx(() {
      final preferences = controller.profileDetails.value?.partnerPreferences;
      if (preferences == null) return SizedBox.shrink();

      return _buildSection(
        'Partner Preferences',
        Icons.favorite_outline,
        Column(
          children: [
            _buildDetailRow('Age Range', preferences.ageRange),
            _buildDetailRow('Height Range', preferences.heightRange),
            _buildDetailRow('Marital Status', preferences.maritalStatus),
            _buildDetailRow('Education', preferences.education),
            _buildDetailRow('Occupation', preferences.occupation),
            _buildDetailRow('Location', preferences.location),
          ],
        ),
      );
    });
  }

  Widget _buildSection(String title, IconData icon, Widget child) {
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
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
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
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
