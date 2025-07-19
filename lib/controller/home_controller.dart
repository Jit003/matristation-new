import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Toggle switch for Regular/Prime
  var isRegularSelected = true.obs;
  var showPrimeBox = false.obs;

  // Marital status selection
  var selectedMaritalStatus = 'All'.obs;
  var showMaritalPopup = false.obs;
  final maritalOptions = ['All', 'Fresh', 'Re Marriage'].obs;

  // Profile view toggle (Grid/List)
  var isGridView = true.obs;

  // Sample data
  var profileStats = <ProfileStat>[].obs;
  var specialCategories = <SpecialCategory>[].obs;
  var preferredProfiles = <UserProfile>[].obs;
  var highProfiles = <UserProfile>[].obs;
  var mostViewedProfiles = <UserProfile>[].obs;
  var services = <ServiceItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    // Profile stats data
    profileStats.value = [
      ProfileStat(icon: Icons.visibility, label: 'Profile \nVisited', count: 25, color: Colors.pink),
      ProfileStat(icon: Icons.thumb_down, label: 'Declined\n Interest', count: 8, color: Colors.pink),
      ProfileStat(icon: Icons.favorite, label: 'Shortlisted', count: 12, color: Colors.pink),
      ProfileStat(icon: Icons.chat, label: 'Messages', count: 5, color: Colors.pink),
      ProfileStat(icon: Icons.star, label: 'Premium\n Views', count: 18, color: Colors.pink),
      ProfileStat(icon: Icons.person_add, label: 'New\n Matches', count: 32, color: Colors.pink),
    ];

    // Special categories data
    specialCategories.value = [
      SpecialCategory(title: 'IAS Officer', image: '/placeholder.svg?height=60&width=60'),
      SpecialCategory(title: 'Doctor', image: '/placeholder.svg?height=60&width=60'),
      SpecialCategory(title: 'CA/CPA', image: '/placeholder.svg?height=60&width=60'),
      SpecialCategory(title: 'Teacher', image: '/placeholder.svg?height=60&width=60'),
    ];

    // Sample profiles
    preferredProfiles.value = [
      UserProfile(
        id: '1',
        name: 'Priya Sharma',
        age: 26,
        height: '5\'4"',
        address: 'Mumbai, Maharashtra',
        education: 'MBA Finance',
        profession: 'Software Engineer',
        image: '/placeholder.svg?height=200&width=200',
        isOnline: true,
        isPremium: true,
      ),
      UserProfile(
        id: '2',
        name: 'Anita Patel',
        age: 24,
        height: '5\'2"',
        address: 'Ahmedabad, Gujarat',
        education: 'B.Tech IT',
        profession: 'UI/UX Designer',
        image: '/placeholder.svg?height=200&width=200',
        isOnline: false,
        isPremium: false,
      ),
      UserProfile(
        id: '3',
        name: 'Kavya Reddy',
        age: 28,
        height: '5\'6"',
        address: 'Hyderabad, Telangana',
        education: 'MS Computer Science',
        profession: 'Data Scientist',
        image: '/placeholder.svg?height=200&width=200',
        isOnline: true,
        isPremium: true,
      ),
    ];

    highProfiles.value = [
      UserProfile(
        id: '4',
        name: 'Dr. Meera Singh',
        age: 29,
        height: '5\'5"',
        address: 'Delhi, Delhi',
        education: 'MBBS, MD',
        profession: 'Cardiologist',
        image: '/placeholder.svg?height=200&width=200',
        isOnline: true,
        isPremium: true,
      ),
      UserProfile(
        id: '5',
        name: 'Sneha Gupta',
        age: 27,
        height: '5\'3"',
        address: 'Bangalore, Karnataka',
        education: 'CA, MBA',
        profession: 'Finance Director',
        image: '/placeholder.svg?height=200&width=200',
        isOnline: false,
        isPremium: true,
      ),
    ];

    mostViewedProfiles.value = [
      UserProfile(
        id: '6',
        name: 'Riya Jain',
        age: 25,
        height: '5\'1"',
        address: 'Pune, Maharashtra',
        education: 'B.Com',
        profession: 'Business Analyst',
        image: '/placeholder.svg?height=200&width=200',
        isOnline: true,
        isPremium: false,
      ),
      UserProfile(
        id: '7',
        name: 'Pooja Agarwal',
        age: 26,
        height: '5\'4"',
        address: 'Jaipur, Rajasthan',
        education: 'B.Tech CSE',
        profession: 'Product Manager',
        image: '/placeholder.svg?height=200&width=200',
        isOnline: false,
        isPremium: true,
      ),
    ];

    // Services data
    services.value = [
      ServiceItem(
        title: 'Profile Verification',
        description: 'Get your profile verified',
        image: '/placeholder.svg?height=80&width=80',
        price: '₹999',
      ),
      ServiceItem(
        title: 'Premium Membership',
        description: 'Unlock premium features',
        image: '/placeholder.svg?height=80&width=80',
        price: '₹2999',
      ),
      ServiceItem(
        title: 'Profile Boost',
        description: 'Increase profile visibility',
        image: '/placeholder.svg?height=80&width=80',
        price: '₹499',
      ),
      ServiceItem(
        title: 'Personalized Matchmaking',
        description: 'Get expert assistance',
        image: '/placeholder.svg?height=80&width=80',
        price: '₹4999',
      ),
    ];
  }

  void toggleMembership(bool isRegular) {
    isRegularSelected.value = isRegular;
    if (!isRegular) {
      showPrimeBox.value = true;
      Future.delayed(Duration(seconds: 3), () {
        showPrimeBox.value = false;
        isRegularSelected.value = true;
      });
    }
  }

  void selectMaritalStatus(String status) {
    selectedMaritalStatus.value = status;
    showMaritalPopup.value = false;
  }

  void toggleMaritalPopup() {
    showMaritalPopup.value = !showMaritalPopup.value;
  }

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  void onProfileTap(UserProfile profile) {
    Get.snackbar(
      'Profile Viewed',
      'Viewing ${profile.name}\'s profile',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }

  void onServiceTap(ServiceItem service) {
    Get.snackbar(
      'Service Selected',
      '${service.title} - ${service.price}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }
}

// Data Models
class ProfileStat {
  final IconData icon;
  final String label;
  final int count;
  final Color color;

  ProfileStat({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
  });
}

class SpecialCategory {
  final String title;
  final String image;

  SpecialCategory({
    required this.title,
    required this.image,
  });
}

class UserProfile {
  final String id;
  final String name;
  final int age;
  final String height;
  final String address;
  final String education;
  final String profession;
  final String image;
  final bool isOnline;
  final bool isPremium;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.address,
    required this.education,
    required this.profession,
    required this.image,
    required this.isOnline,
    required this.isPremium,
  });
}

class ServiceItem {
  final String title;
  final String description;
  final String image;
  final String price;

  ServiceItem({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });
}
