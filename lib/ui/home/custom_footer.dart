import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utility/constant.dart';

class HomeFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          // Quick links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFooterLink('About Us', Icons.info_outline),
              _buildFooterLink('Privacy', Icons.privacy_tip_outlined),
              _buildFooterLink('Terms', Icons.description_outlined),
              _buildFooterLink('Support', Icons.support_agent),
            ],
          ),

          SizedBox(height: 24),

          // Social media
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.facebook, () {}),
              SizedBox(width: 16),
              _buildSocialIcon(Icons.camera_alt, () {}), // Instagram
              SizedBox(width: 16),
              _buildSocialIcon(Icons.alternate_email, () {}), // Twitter
              SizedBox(width: 16),
              _buildSocialIcon(Icons.video_call, () {}), // YouTube
            ],
          ),
          // Contact info
          // Copyright
        ],
      ),
    );
  }

  Widget _buildFooterLink(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          title,
          'Coming soon...',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
        );
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: Color(0xFF4CAF50),
            size: 20,
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Color(0xFF4CAF50),
          size: 20,
        ),
      ),
    );
  }
}
