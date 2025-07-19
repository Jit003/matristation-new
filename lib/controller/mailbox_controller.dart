import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailboxController extends GetxController with GetSingleTickerProviderStateMixin {
  // Tab controller for main tabs
  late TabController tabController;

  // Observable variables
  var isLoading = false.obs;
  var selectedTabIndex = 0.obs;
  var selectedFilterIndex = 0.obs;
  var searchQuery = ''.obs;

  // Data lists for different tabs
  var receivedMessages = <MailboxItem>[].obs;
  var sentMessages = <MailboxItem>[].obs;
  var requests = <MailboxItem>[].obs;
  var calls = <MailboxItem>[].obs;

  // Filter options
  final filterOptions = ['All', 'Pending', 'Accepted', 'Declined'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
    loadMailboxData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // Load mailbox data
  Future<void> loadMailboxData() async {
    isLoading.value = true;
    try {
      // TODO: Replace with actual API calls
      await Future.delayed(Duration(seconds: 1));
      loadMockData();
    } catch (e) {
      print('Error loading mailbox data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Mock data - replace with actual API calls
  void loadMockData() {
    receivedMessages.value = [
      MailboxItem(
        id: 'MAT001',
        name: 'Priya Sharma',
        age: 26,
        address: 'Mumbai, Maharashtra',
        profession: 'Software Engineer',
        status: 'pending',
        timestamp: '2 hours ago',
        message: 'Hi, I found your profile interesting...',
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
      ),
      MailboxItem(
        id: 'MAT002',
        name: 'Anjali Patel',
        age: 28,
        address: 'Ahmedabad, Gujarat',
        profession: 'Doctor',
        status: 'accepted',
        timestamp: '1 day ago',
        message: 'Thank you for your interest...',
        profileImage: 'https://placeholder.com/150',
        isOnline: false,
      ),
      MailboxItem(
        id: 'MAT003',
        name: 'Kavya Reddy',
        age: 25,
        address: 'Hyderabad, Telangana',
        profession: 'Teacher',
        status: 'pending',
        timestamp: '3 days ago',
        message: 'Would like to know more about you...',
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
      ),
    ];

    sentMessages.value = [
      MailboxItem(
        id: 'MAT004',
        name: 'Ravi Kumar',
        age: 30,
        address: 'Bangalore, Karnataka',
        profession: 'Manager',
        status: 'accepted',
        timestamp: '1 hour ago',
        message: 'Hello, I am interested in your profile...',
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
      ),
      MailboxItem(
        id: 'MAT005',
        name: 'Amit Singh',
        age: 32,
        address: 'Delhi, India',
        profession: 'Business Owner',
        status: 'pending',
        timestamp: '5 hours ago',
        message: 'Hi, would you like to connect?',
        profileImage: 'https://placeholder.com/150',
        isOnline: false,
      ),
    ];

    requests.value = [
      MailboxItem(
        id: 'MAT006',
        name: 'Sneha Gupta',
        age: 24,
        address: 'Pune, Maharashtra',
        profession: 'Designer',
        status: 'pending',
        timestamp: '30 minutes ago',
        message: 'Interest request received',
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
      ),
      MailboxItem(
        id: 'MAT007',
        name: 'Meera Joshi',
        age: 27,
        address: 'Jaipur, Rajasthan',
        profession: 'Lawyer',
        status: 'pending',
        timestamp: '2 hours ago',
        message: 'Profile view request',
        profileImage: 'https://placeholder.com/150',
        isOnline: false,
      ),
    ];

    calls.value = [
      MailboxItem(
        id: 'MAT008',
        name: 'Rohit Sharma',
        age: 29,
        address: 'Chennai, Tamil Nadu',
        profession: 'Engineer',
        status: 'accepted',
        timestamp: '1 hour ago',
        message: 'Video call completed',
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
      ),
    ];
  }

  // Get current tab data
  List<MailboxItem> getCurrentTabData() {
    switch (selectedTabIndex.value) {
      case 0:
        return receivedMessages;
      case 1:
        return sentMessages;
      case 2:
        return requests;
      case 3:
        return calls;
      default:
        return receivedMessages;
    }
  }

  // Filter data based on selected filter
  List<MailboxItem> getFilteredData() {
    List<MailboxItem> data = getCurrentTabData();
    String selectedFilter = filterOptions[selectedFilterIndex.value].toLowerCase();

    if (selectedFilter == 'all') {
      return data;
    }

    return data.where((item) => item.status == selectedFilter).toList();
  }

  // Handle filter selection
  void selectFilter(int index) {
    selectedFilterIndex.value = index;
  }

  // Handle search
  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  // Handle profile tap
  void onProfileTap(String profileId) {
    Get.toNamed('/profile-details', arguments: profileId);
  }

  // Handle message tap
  void onMessageTap(String profileId) {
    Get.toNamed('/chat', arguments: profileId);
  }

  // Handle call tap
  void onCallTap(String profileId) {
    Get.toNamed('/video-call', arguments: profileId);
  }

  // Handle request actions
  void acceptRequest(String profileId) {
    // TODO: Implement accept request API
    print('Request accepted for: $profileId');
  }

  void declineRequest(String profileId) {
    // TODO: Implement decline request API
    print('Request declined for: $profileId');
  }
}

// Mailbox Item Model
class MailboxItem {
  final String id;
  final String name;
  final int age;
  final String address;
  final String profession;
  final String status;
  final String timestamp;
  final String message;
  final String profileImage;
  final bool isOnline;

  MailboxItem({
    required this.id,
    required this.name,
    required this.age,
    required this.address,
    required this.profession,
    required this.status,
    required this.timestamp,
    required this.message,
    required this.profileImage,
    required this.isOnline,
  });

  factory MailboxItem.fromJson(Map<String, dynamic> json) {
    return MailboxItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      address: json['address'] ?? '',
      profession: json['profession'] ?? '',
      status: json['status'] ?? '',
      timestamp: json['timestamp'] ?? '',
      message: json['message'] ?? '',
      profileImage: json['profile_image'] ?? '',
      isOnline: json['is_online'] ?? false,
    );
  }
}