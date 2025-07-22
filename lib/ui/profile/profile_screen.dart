import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/profile/profile_header.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBarWidget(title: 'Profile'),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50)))
          : SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: 8),
            _buildMenuOptions(),
            SizedBox(height: 20),
          ],
        ),
      )),
    );
  }


  Widget _buildMenuOptions() {
    final menuItems = [
      {
        'key': 'my_profile',
        'title': 'My Profile',
        'subtitle': 'My Profile',
        'icon': Icons.person_outline,
        'color': Color(0xFF4CAF50),
      },
      {
        'key': 'blocked_users',
        'title': 'Blocked Users',
        'subtitle': 'Manage blocked profiles',
        'icon': Icons.block,
        'color': Color(0xFFFF5722),
      },
      {
        'key': 'notifications',
        'title': 'Notifications',
        'subtitle': 'Manage your notification preferences',
        'icon': Icons.notifications_none,
        'color': Color(0xFF2196F3),
      },
      {
        'key': 'wallet',
        'title': 'Wallet',
        'subtitle': 'View balance and transaction history',
        'icon': Icons.account_balance_wallet_outlined,
        'color': Color(0xFF9C27B0),
      },
      {
        'key': 'refer_earn',
        'title': 'Refer & Earn',
        'subtitle': 'Invite friends and earn rewards',
        'icon': Icons.card_giftcard,
        'color': Color(0xFFFF9800),
      },
      {
        'key': 'privacy_policy',
        'title': 'Privacy Policy',
        'subtitle': 'Read our privacy policy',
        'icon': Icons.security,
        'color': Color(0xFF607D8B),
      },
      {
        'key': 'terms_conditions',
        'title': 'Terms and Conditions',
        'subtitle': 'Read terms and conditions',
        'icon': Icons.description_outlined,
        'color': Color(0xFF795548),
      },
      {
        'key': 'refund_policy',
        'title': 'Refund Policy',
        'subtitle': 'Learn about our refund policy',
        'icon': Icons.money,
        'color': Color(0xFF009688),
      },
      {
        'key': 'share_app',
        'title': 'Share App',
        'subtitle': 'Learn about our refund policy',
        'icon': Icons.money,
        'color': Color(0xFF009688),
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
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
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Color(0xFF4CAF50),
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          ...menuItems.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> item = entry.value;
            bool isLast = index == menuItems.length - 1;

            return _buildMenuItem(
              title: item['title'],
              subtitle: item['subtitle'],
              icon: item['icon'],
              color: item['color'],
              onTap: () => controller.onMenuTap(item['key']),
              showDivider: !isLast,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 22,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 68,
            endIndent: 20,
            color: Colors.grey[200],
          ),
      ],
    );
  }
}
