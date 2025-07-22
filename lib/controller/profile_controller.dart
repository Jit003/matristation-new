import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/profile/my_profile_screen.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var userProfile = UserProfile().obs;
  var viewCount = 0.obs;
  var interestCount = 0.obs;
  var messageCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  void loadUserProfile() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      userProfile.value = UserProfile(
        id: 'MAT123456',
        name: 'Priya Sharma',
        age: 26,
        location: 'Mumbai, Maharashtra',
        profileImage: '/placeholder.svg?height=120&width=120&text=Priya',
        isPremium: true,
      );

      viewCount.value = 245;
      interestCount.value = 18;
      messageCount.value = 12;

      isLoading.value = false;
    });
  }

  void editProfile() {
    Get.snackbar(
      'Edit Profile',
      'Redirecting to edit profile screen...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void editProfileImage() {
    Get.snackbar(
      'Change Photo',
      'Photo picker will open here...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void upgradePlan() {
    Get.snackbar(
      'Upgrade Plan',
      'Redirecting to upgrade plan screen...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void changePassword() {
    Get.snackbar(
      'Change Password',
      'Redirecting to change password screen...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void onMenuTap(String key) {
    switch (key) {
      case 'my_profile':
        Get.to(()=>MyProfileScreen());
        break;
      case 'blocked_users':
        Get.snackbar('Blocked Users', 'Opening blocked users list...');
        break;
      case 'notifications':
        Get.snackbar('Notifications', 'Opening notifications...');
        break;
      case 'wallet':
        Get.snackbar('Wallet', 'Opening wallet...');
        break;
      case 'refer_earn':
        Get.snackbar('Refer & Earn', 'Opening referral program...');
        break;
      case 'privacy_policy':
        Get.snackbar('Privacy Policy', 'Opening privacy policy...');
        break;
      case 'terms_conditions':
        Get.snackbar('Terms & Conditions', 'Opening terms...');
        break;
      case 'refund_policy':
        Get.snackbar('Refund Policy', 'Opening refund policy...');
        break;
      case 'share_app':
        Get.snackbar('Sharing', 'Opening refund policy...');
        break;
    }
  }
}

class UserProfile {
  final String id;
  final String name;
  final int age;
  final String location;
  final String profileImage;
  final bool isPremium;

  UserProfile({
    this.id = '',
    this.name = '',
    this.age = 0,
    this.location = '',
    this.profileImage = '',
    this.isPremium = false,
  });
}
