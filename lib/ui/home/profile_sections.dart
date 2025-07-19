import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../widget/profile_card_widget.dart';

class ProfileSections extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileSection(
          'Preferred Profiles',
          controller.preferredProfiles,
          showViewToggle: true,
          sectionColor: Color(0xFF4CAF50),
        ),
        _buildProfileSection(
          'High Profiles',
          controller.highProfiles,
          showViewToggle: true,
          sectionColor: Color(0xFFFF6B35),
        ),
        _buildProfileSection(
          'Most Viewed',
          controller.mostViewedProfiles,
          showViewToggle: true,
          sectionColor: Color(0xFF6C5CE7),
        ),
      ],
    );
  }

  Widget _buildProfileSection(
      String title,
      RxList<UserProfile> profiles, {
        bool showViewToggle = false,
        required Color sectionColor,
      }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Section Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  sectionColor.withOpacity(0.1),
                  sectionColor.withOpacity(0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: sectionColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: sectionColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getSectionIcon(title),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${profiles.length} profiles available',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (showViewToggle)
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Obx(() => GestureDetector(
                          onTap: () => controller.isGridView.value = true,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: controller.isGridView.value
                                  ? sectionColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.grid_view_rounded,
                              color: controller.isGridView.value
                                  ? Colors.white
                                  : Colors.grey[600],
                              size: 18,
                            ),
                          ),
                        )),
                        SizedBox(width: 4),
                        Obx(() => GestureDetector(
                          onTap: () => controller.isGridView.value = false,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: !controller.isGridView.value
                                  ? sectionColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.view_list_rounded,
                              color: !controller.isGridView.value
                                  ? Colors.white
                                  : Colors.grey[600],
                              size: 18,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Profile Content
          Obx(() => controller.isGridView.value
              ? _buildGridView(profiles, sectionColor)
              : _buildListView(profiles, sectionColor)),
        ],
      ),
    );
  }

  IconData _getSectionIcon(String title) {
    switch (title) {
      case 'Preferred Profiles':
        return Icons.favorite_rounded;
      case 'High Profiles':
        return Icons.star_rounded;
      case 'Most Viewed Profiles':
        return Icons.trending_up_rounded;
      default:
        return Icons.person_rounded;
    }
  }

  Widget _buildGridView(RxList<UserProfile> profiles, Color sectionColor) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return ProfileCard(
          profile: profiles[index],
          sectionColor: sectionColor,
          isGridView: true,
        );
      },
    );
  }

  Widget _buildListView(RxList<UserProfile> profiles, Color sectionColor) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return ProfileCard(
          profile: profiles[index],
          sectionColor: sectionColor,
          isGridView: false,
        );
      },
    );
  }
}
