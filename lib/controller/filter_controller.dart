import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  // Loading state
  var isLoading = false.obs;
  var isApplyingFilter = false.obs;

  // Current selected filter category
  var selectedFilterCategory = 0.obs;

  // Filter categories
  final filterCategories = [
    FilterCategory(
      id: 'gender',
      title: 'Gender',
      icon: Icons.people_outline,
      type: FilterType.singleSelect,
    ),
    FilterCategory(
      id: 'age',
      title: 'Age',
      icon: Icons.cake_outlined,
      type: FilterType.range,
    ),
    FilterCategory(
      id: 'height',
      title: 'Height',
      icon: Icons.height,
      type: FilterType.range,
    ),
    FilterCategory(
      id: 'marital_status',
      title: 'Marital Status',
      icon: Icons.favorite_outline,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'religion',
      title: 'Religion',
      icon: Icons.account_balance,
      type: FilterType.singleSelect,
    ),
    FilterCategory(
      id: 'caste',
      title: 'Caste',
      icon: Icons.group_outlined,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'mother_tongue',
      title: 'Mother Tongue',
      icon: Icons.language,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'country',
      title: 'Country',
      icon: Icons.public,
      type: FilterType.singleSelect,
    ),
    FilterCategory(
      id: 'state',
      title: 'State',
      icon: Icons.location_city,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'city',
      title: 'City',
      icon: Icons.location_on_outlined,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'education',
      title: 'Education',
      icon: Icons.school_outlined,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'occupation',
      title: 'Occupation',
      icon: Icons.work_outline,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'income',
      title: 'Annual Income',
      icon: Icons.currency_rupee,
      type: FilterType.singleSelect,
    ),
    FilterCategory(
      id: 'diet',
      title: 'Diet',
      icon: Icons.restaurant_outlined,
      type: FilterType.multiSelect,
    ),
    FilterCategory(
      id: 'smoking',
      title: 'Smoking',
      icon: Icons.smoking_rooms_outlined,
      type: FilterType.singleSelect,
    ),
    FilterCategory(
      id: 'drinking',
      title: 'Drinking',
      icon: Icons.local_bar_outlined,
      type: FilterType.singleSelect,
    ),
  ].obs;

  // Filter options - These will come from API
  var filterOptions = <String, List<String>>{}.obs;

  // Selected values
  var selectedValues = <String, dynamic>{}.obs;

  // Range values
  var selectedAgeRange = RangeValues(21, 35).obs;
  var selectedHeightRange = RangeValues(4.5, 6.5).obs;

  @override
  void onInit() {
    super.onInit();
    loadFilterOptions();
    initializeSelectedValues();
  }

  void initializeSelectedValues() {
    selectedValues.value = {
      'gender': '',
      'age': [21, 35],
      'height': [4.5, 6.5],
      'marital_status': <String>[],
      'religion': '',
      'caste': <String>[],
      'mother_tongue': <String>[],
      'country': '',
      'state': <String>[],
      'city': <String>[],
      'education': <String>[],
      'occupation': <String>[],
      'income': '',
      'diet': <String>[],
      'smoking': '',
      'drinking': '',
    };
  }

  void loadFilterOptions() {
    // Simulate API response - In real app, this will come from backend
    filterOptions.value = {
      'gender': ['Male', 'Female'],
      'marital_status': ['Never Married', 'Divorced', 'Widowed', 'Separated'],
      'religion': ['Hindu', 'Muslim', 'Christian', 'Sikh', 'Buddhist', 'Jain', 'Parsi', 'Jewish', 'Other'],
      'caste': ['Brahmin', 'Kshatriya', 'Vaishya', 'Shudra', 'Jain', 'Maratha', 'Rajput', 'Agarwal', 'Gupta', 'Other'],
      'mother_tongue': ['Hindi', 'English', 'Bengali', 'Telugu', 'Marathi', 'Tamil', 'Gujarati', 'Urdu', 'Kannada', 'Malayalam', 'Punjabi', 'Other'],
      'country': ['India', 'USA', 'UK', 'Canada', 'Australia', 'UAE', 'Singapore', 'Other'],
      'state': ['Maharashtra', 'Delhi', 'Karnataka', 'Tamil Nadu', 'Gujarat', 'Rajasthan', 'Uttar Pradesh', 'West Bengal', 'Telangana', 'Haryana', 'Other', 'Uttar Pradesh', 'West Bengal', 'Telangana',],
      'city': ['Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Hyderabad', 'Pune', 'Kolkata', 'Ahmedabad', 'Jaipur', 'Lucknow', 'Other'],
      'education': ['Graduate', 'Post Graduate', 'Doctorate', 'Diploma', 'Professional', 'High School', 'Other'],
      'occupation': ['Software Engineer', 'Doctor', 'Teacher', 'Business', 'Government Job', 'Private Job', 'Self Employed', 'Student', 'Other'],
      'income': ['Below 3 Lakhs', '3-5 Lakhs', '5-10 Lakhs', '10-15 Lakhs', '15-25 Lakhs', '25-50 Lakhs', 'Above 50 Lakhs'],
      'diet': ['Vegetarian', 'Non-Vegetarian', 'Vegan', 'Jain Vegetarian'],
      'smoking': ['Never', 'Occasionally', 'Regularly', 'Trying to Quit'],
      'drinking': ['Never', 'Occasionally', 'Socially', 'Regularly'],
    };
  }

  void selectFilterCategory(int index) {
    selectedFilterCategory.value = index;
  }

  void updateSingleSelect(String categoryId, String value) {
    if (selectedValues[categoryId] == value) {
      selectedValues[categoryId] = '';
    } else {
      selectedValues[categoryId] = value;
    }
    selectedValues.refresh();
  }

  void updateMultiSelect(String categoryId, String value) {
    List<String> currentValues = List<String>.from(selectedValues[categoryId] ?? []);
    if (currentValues.contains(value)) {
      currentValues.remove(value);
    } else {
      currentValues.add(value);
    }
    selectedValues[categoryId] = currentValues;
    selectedValues.refresh();
  }

  void updateAgeRange(RangeValues range) {
    selectedAgeRange.value = range;
    selectedValues['age'] = [range.start.round(), range.end.round()];
    selectedValues.refresh();
  }

  void updateHeightRange(RangeValues range) {
    selectedHeightRange.value = range;
    selectedValues['height'] = [range.start, range.end];
    selectedValues.refresh();
  }

  void clearAllFilters() {
    initializeSelectedValues();
    selectedAgeRange.value = RangeValues(21, 35);
    selectedHeightRange.value = RangeValues(4.5, 6.5);
  }

  int getActiveFiltersCount() {
    int count = 0;
    selectedValues.forEach((key, value) {
      if (key == 'age' || key == 'height') {
        // Skip range filters for count (or implement custom logic)
        return;
      }
      if (value is String && value.isNotEmpty) {
        count++;
      } else if (value is List && value.isNotEmpty) {
        count++;
      }
    });
    return count;
  }

  String getSelectedCountForCategory(String categoryId) {
    var value = selectedValues[categoryId];
    if (value is String && value.isNotEmpty) {
      return '1';
    } else if (value is List && value.isNotEmpty) {
      return '${value.length}';
    }
    return '';
  }

  Map<String, dynamic> getFilterParams() {
    return Map<String, dynamic>.from(selectedValues);
  }

  Future<void> applyFilters() async {
    isApplyingFilter.value = true;

    try {
      Map<String, dynamic> filterParams = getFilterParams();

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      Get.back(result: filterParams);

      Get.snackbar(
        'Filters Applied',
        'Your search filters have been applied successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF4CAF50),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to apply filters. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isApplyingFilter.value = false;
    }
  }
}

// Data Models
class FilterCategory {
  final String id;
  final String title;
  final IconData icon;
  final FilterType type;

  FilterCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.type,
  });
}

enum FilterType {
  singleSelect,
  multiSelect,
  range,
}
