import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../ui/chat/indivisual_chat_screen.dart';

class ChatController extends GetxController with GetSingleTickerProviderStateMixin {
  // Tab controller for main tabs
  late TabController tabController;

  // Observable variables
  var isLoading = false.obs;
  var selectedTabIndex = 0.obs;
  var searchQuery = ''.obs;

  // Data lists for different tabs
  var receivedChats = <ChatItem>[].obs;
  var liveResponseChats = <ChatItem>[].obs;
  var callChats = <ChatItem>[].obs;

  // Add these properties to your ChatController class:

// Filter options
  final filterOptions = ['All', 'Online', 'Unread', 'Recent', 'Favorites'].obs;
  var selectedFilterIndex = 0.obs;

// Add these methods to your ChatController class:

// Handle filter selection
  void selectFilter(int index) {
    selectedFilterIndex.value = index;
  }

// Get filtered data based on selected filter
  List<ChatItem> getFilteredData() {
    List<ChatItem> data = getCurrentTabData();
    String selectedFilter = filterOptions[selectedFilterIndex.value];

    switch (selectedFilter) {
      case 'All':
        return data;
      case 'Online':
        return data.where((item) => item.isOnline).toList();
      case 'Unread':
        return data.where((item) => item.unreadCount > 0).toList();
      case 'Recent':
      // Filter chats from last 24 hours
        DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
        return data.where((item) {
          // You'll need to convert timestamp string to DateTime for comparison
          // This is a simplified example
          return item.timestamp.contains('hour') || item.timestamp.contains('min');
        }).toList();
      case 'Favorites':
      // Assuming you have a favorites property in ChatItem
      // return data.where((item) => item.isFavorite).toList();
        return data; // Placeholder - implement based on your data structure
      default:
        return data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
    loadChatData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // Load chat data
  Future<void> loadChatData() async {
    isLoading.value = true;
    try {
      // TODO: Replace with actual API calls
      await Future.delayed(Duration(seconds: 1));
      loadMockData();
    } catch (e) {
      print('Error loading chat data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Mock data - replace with actual API calls
  void loadMockData() {
    receivedChats.value = [
      ChatItem(
        id: 'chat001',
        name: 'Priya Sharma',
        lastMessage: 'Hi, how are you doing?',
        timestamp: '2:30 PM',
        unreadCount: 3,
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
        lastSeen: 'Online',
      ),
      ChatItem(
        id: 'chat002',
        name: 'Anjali Patel',
        lastMessage: 'Thank you for connecting with me',
        timestamp: '1:45 PM',
        unreadCount: 0,
        profileImage: 'https://placeholder.com/150',
        isOnline: false,
        lastSeen: '2 hours ago',
      ),
      ChatItem(
        id: 'chat003',
        name: 'Kavya Reddy',
        lastMessage: 'Would love to know more about you',
        timestamp: '12:20 PM',
        unreadCount: 1,
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
        lastSeen: 'Online',
      ),
      ChatItem(
        id: 'chat004',
        name: 'Sneha Gupta',
        lastMessage: 'Nice talking to you yesterday',
        timestamp: 'Yesterday',
        unreadCount: 0,
        profileImage: 'https://placeholder.com/150',
        isOnline: false,
        lastSeen: '1 day ago',
      ),
    ];

    liveResponseChats.value = [
      ChatItem(
        id: 'live001',
        name: 'Ravi Kumar',
        lastMessage: 'Are you there?',
        timestamp: '3:15 PM',
        unreadCount: 2,
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
        lastSeen: 'Online',
        isTyping: true,
      ),
      ChatItem(
        id: 'live002',
        name: 'Amit Singh',
        lastMessage: 'Let me know when you are free',
        timestamp: '2:50 PM',
        unreadCount: 1,
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
        lastSeen: 'Online',
      ),
    ];

    callChats.value = [
      ChatItem(
        id: 'call001',
        name: 'Rohit Sharma',
        lastMessage: 'Missed call',
        timestamp: '4:20 PM',
        unreadCount: 0,
        profileImage: 'https://placeholder.com/150',
        isOnline: false,
        lastSeen: '30 minutes ago',
        callType: 'missed',
      ),
      ChatItem(
        id: 'call002',
        name: 'Meera Joshi',
        lastMessage: 'Video call - 15 min',
        timestamp: '11:30 AM',
        unreadCount: 0,
        profileImage: 'https://placeholder.com/150',
        isOnline: true,
        lastSeen: 'Online',
        callType: 'video',
      ),
    ];
  }

  // Get current tab data
  List<ChatItem> getCurrentTabData() {
    switch (selectedTabIndex.value) {
      case 0:
        return receivedChats;
      case 1:
        return liveResponseChats;
      case 2:
        return callChats;
      default:
        return receivedChats;
    }
  }

  // Handle search
  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  // Handle chat tap
  void onChatTap(ChatItem chatItem) {
    Get.to(() => IndividualChatScreen());
  }

  // Handle call tap
  void onCallTap(String chatId) {
    Get.toNamed('/video-call', arguments: chatId);
  }
}

// Chat Item Model
class ChatItem {
  final String id;
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final String profileImage;
  final bool isOnline;
  final String lastSeen;
  final bool isTyping;
  final String? callType;

  ChatItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.profileImage,
    required this.isOnline,
    required this.lastSeen,
    this.isTyping = false,
    this.callType,
  });
}