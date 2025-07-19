import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/match_profile_model.dart';
import '../ui/match/caste_details_screen.dart';
import '../ui/match/state_details_screen.dart';

class MatchController extends GetxController with GetTickerProviderStateMixin {
  // Loading states
  var isLoading = false.obs;
  var isLoadingStates = false.obs;
  var isLoadingCastes = false.obs;
  var isLoadingProfiles = false.obs;

  // Toggle state
  var isStateMode = true.obs; // true for states, false for castes

  // Data lists
  var states = <String>[].obs;
  var castes = <String>[].obs;
  var profiles = <MatchProfile>[].obs;

  // Selected filters
  var selectedState = 'All'.obs;
  var selectedCaste = 'All'.obs;
  var selectedMatchType = 'All'.obs;

  // Filter buttons
  var matchTypeButtons = <String>[].obs;
  var casteButtons = <String>[].obs;

  // Search
  var searchController = TextEditingController();
  var searchQuery = ''.obs;

  // Animation
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  var animatedTexts = ['Find Your Perfect Match', 'Discover New Connections', 'Your Soulmate Awaits'].obs;
  var currentTextIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _initializeData();
    fetchStates();
    fetchCastes();
    fetchProfiles();
    _startTextAnimation();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    animationController.repeat(reverse: true);
  }

  void _initializeData() {
    matchTypeButtons.value = ['All', 'New', 'Daily', 'My Matches', 'Premium', 'Recently Viewed'];
  }

  void _startTextAnimation() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      currentTextIndex.value = (currentTextIndex.value + 1) % animatedTexts.length;
    });
  }

  // API calls
  Future<void> fetchStates() async {
    isLoadingStates.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));
      states.value = [
        'All',
        'Andhra Pradesh',
        'Assam',
        'Bihar',
        'Chhattisgarh',
        'Delhi',
        'Gujarat',
        'Haryana',
        'Karnataka',
        'Kerala',
        'Madhya Pradesh',
        'Maharashtra',
        'Odisha',
        'Punjab',
        'Rajasthan',
        'Tamil Nadu',
        'Telangana',
        'Uttar Pradesh',
        'West Bengal',
      ];
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch states');
    } finally {
      isLoadingStates.value = false;
    }
  }

  Future<void> fetchCastes() async {
    isLoadingCastes.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));
      castes.value = [
        'All',
        'Brahmin',
        'Kshatriya',
        'Vaishya',
        'Kayastha',
        'Agarwal',
        'Baniya',
        'Jat',
        'Rajput',
        'Reddy',
        'Nair',
        'Iyer',
        'Iyengar',
        'Chettiar',
        'Naidu',
        'Patel',
        'Shah',
        'Gupta',
        'Sharma',
        'Verma',
      ];
      casteButtons.value = castes.take(10).toList(); // Show first 10 in buttons
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch castes');
    } finally {
      isLoadingCastes.value = false;
    }
  }

  Future<void> fetchProfiles() async {
    isLoadingProfiles.value = true;
    try {
      // Simulate API call with filters
      await Future.delayed(const Duration(milliseconds: 1000));

      // Mock data - replace with actual API call
      profiles.value = List.generate(20, (index) {
        return MatchProfile(
          id: 'profile_$index',
          name: _getRandomName(index),
          age: 25 + (index % 10),
          height: _getRandomHeight(index),
          location: _getRandomLocation(index),
          education: _getRandomEducation(index),
          profession: _getRandomProfession(index),
          religion: 'Hindu',
          caste: castes[1 + (index % (castes.length - 1))],
          state: states[1 + (index % (states.length - 1))],
          imageUrl: '/placeholder.svg?height=300&width=300&text=Profile${index + 1}',
          isVerified: index % 3 == 0,
          isOnline: index % 4 == 0,
          lastSeen: _getRandomLastSeen(index),
          photos: ['/placeholder.svg?height=300&width=300&text=Photo${index + 1}'],
          profileType: matchTypeButtons[1 + (index % (matchTypeButtons.length - 1))].toLowerCase(),
        );
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch profiles');
    } finally {
      isLoadingProfiles.value = false;
    }
  }

  // Helper methods for mock data
  String _getRandomName(int index) {
    final names = ['Priya', 'Anjali', 'Sneha', 'Pooja', 'Kavya', 'Divya', 'Riya', 'Neha', 'Shreya', 'Aditi'];
    return names[index % names.length];
  }

  String _getRandomHeight(int index) {
    final heights = ['5\'2"', '5\'3"', '5\'4"', '5\'5"', '5\'6"', '5\'7"'];
    return heights[index % heights.length];
  }

  String _getRandomLocation(int index) {
    final locations = ['Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Hyderabad', 'Pune', 'Kolkata', 'Ahmedabad'];
    return locations[index % locations.length];
  }

  String _getRandomEducation(int index) {
    final education = ['B.Tech', 'MBA', 'M.Tech', 'CA', 'Doctor', 'B.Com', 'M.Com', 'BBA'];
    return education[index % education.length];
  }

  String _getRandomProfession(int index) {
    final professions = ['Software Engineer', 'Doctor', 'Teacher', 'Business', 'Consultant', 'Manager', 'Analyst'];
    return professions[index % professions.length];
  }

  String _getRandomLastSeen(int index) {
    final lastSeen = ['Online', '2 hours ago', '1 day ago', '3 days ago', '1 week ago'];
    return lastSeen[index % lastSeen.length];
  }

  // Filter methods
  void toggleMode() {
    isStateMode.value = !isStateMode.value;
  }

  void selectState(String state) {
    selectedState.value = state;
    fetchProfiles(); // Refresh profiles with new filter
  }

  void selectCaste(String caste) {
    selectedCaste.value = caste;
    fetchProfiles(); // Refresh profiles with new filter
  }

  void selectMatchType(String type) {
    selectedMatchType.value = type;
    fetchProfiles(); // Refresh profiles with new filter
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    // Implement search logic here
    fetchProfiles();
  }

  // Navigation methods
  void openStateDetailScreen() {
    Get.to(() => StateDetailScreen());
  }

  void openCasteDetailScreen() {
    Get.to(() => CasteDetailScreen());
  }

  @override
  void onClose() {
    animationController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
