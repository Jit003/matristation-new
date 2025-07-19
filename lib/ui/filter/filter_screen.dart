import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../../controller/filter_controller.dart';

class FilterScreen extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(title: 'Filters'),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left side - Filter Categories
                Container(
                  width: 140,
                  color: Colors.grey[50],
                  child: _buildFilterCategories(),
                ),

                // Divider
                Container(
                  width: 1,
                  color: Colors.grey[200],
                ),

                // Right side - Filter Options
                Expanded(
                  child: _buildFilterOptions(),
                ),
              ],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }


  Widget _buildFilterCategories() {
    return ListView.builder(
      itemCount: controller.filterCategories.length,
      itemBuilder: (context, index) {
        final category = controller.filterCategories[index];
        return _buildFilterCategoryItem(category, index);
      },
    );
  }


  Widget _buildFilterCategoryItem(FilterCategory category, int index) {
    return Obx(() {
      final isSelected = controller.selectedFilterCategory.value == index;
      final selectedCount = controller.getSelectedCountForCategory(category.id);

      return GestureDetector(
        onTap: () => controller.selectFilterCategory(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected ? Color(0xFF4CAF50) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    category.icon,
                    size: 16,
                    color: isSelected ? Color(0xFF4CAF50) : Colors.grey[600],
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Color(0xFF4CAF50) : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (selectedCount.isNotEmpty) ...[
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    selectedCount,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }



  Widget _buildFilterOptions() {
    return Obx(() {
      if (controller.filterCategories.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      final selectedCategory = controller.filterCategories[controller.selectedFilterCategory.value];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  selectedCategory.icon,
                  size: 20,
                  color: Color(0xFF4CAF50),
                ),
                SizedBox(width: 8),
                Text(
                  selectedCategory.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Options
          Expanded(
            child: _buildOptionsList(selectedCategory),
          ),
        ],
      );
    });
  }

  Widget _buildOptionsList(FilterCategory category) {
    switch (category.type) {
      case FilterType.range:
        return _buildRangeOptions(category);
      case FilterType.singleSelect:
        return _buildSingleSelectOptions(category);
      case FilterType.multiSelect:
        return _buildMultiSelectOptions(category);
    }
  }

  Widget _buildRangeOptions(FilterCategory category) {
    if (category.id == 'age') {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
                  ),
                  child: Text(
                    '${controller.selectedAgeRange.value.start.round()} years',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
                Text(
                  'to',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
                  ),
                  child: Text(
                    '${controller.selectedAgeRange.value.end.round()} years',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: 30),
            Obx(() => RangeSlider(
              values: controller.selectedAgeRange.value,
              min: 18,
              max: 60,
              divisions: 42,
              activeColor: Color(0xFF4CAF50),
              inactiveColor: Color(0xFF4CAF50).withOpacity(0.3),
              onChanged: controller.updateAgeRange,
            )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('18', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                Text('60', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ],
        ),
      );
    } else if (category.id == 'height') {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
                  ),
                  child: Text(
                    '${controller.selectedHeightRange.value.start.toStringAsFixed(1)} ft',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
                Text(
                  'to',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
                  ),
                  child: Text(
                    '${controller.selectedHeightRange.value.end.toStringAsFixed(1)} ft',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: 30),
            Obx(() => RangeSlider(
              values: controller.selectedHeightRange.value,
              min: 4.0,
              max: 7.0,
              divisions: 30,
              activeColor: Color(0xFF4CAF50),
              inactiveColor: Color(0xFF4CAF50).withOpacity(0.3),
              onChanged: controller.updateHeightRange,
            )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('4.0 ft', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                Text('7.0 ft', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildSingleSelectOptions(FilterCategory category) {
    return Obx(() {
      final options = controller.filterOptions[category.id] ?? [];
      final selected = controller.selectedValues[category.id];

      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = selected == option;

          return GestureDetector(
            onTap: () => controller.updateSingleSelect(category.id, option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4CAF50).withOpacity(0.1) : Colors.transparent,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[100]!, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF4CAF50) : Colors.grey[400]!,
                        width: 2,
                      ),
                      color: isSelected ? const Color(0xFF4CAF50) : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? const Color(0xFF4CAF50) : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildMultiSelectOptions(FilterCategory category) {
    return Obx(() {
      final options = controller.filterOptions[category.id] ?? [];
      final selectedList = List<String>.from(controller.selectedValues[category.id] ?? []);

      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = selectedList.contains(option);

          return GestureDetector(
            onTap: () => controller.updateMultiSelect(category.id, option),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.transparent,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[100]!, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected ? Color(0xFF4CAF50) : Colors.grey[400]!,
                        width: 2,
                      ),
                      color: isSelected ? Color(0xFF4CAF50) : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                        : null,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? Color(0xFF4CAF50) : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }


  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: () {
                controller.clearAllFilters();
                Get.snackbar(
                  'Filters Cleared',
                  'All filters have been cleared',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey[600],
                  colorText: Colors.white,
                  duration: Duration(seconds: 1),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF4CAF50),
                side: BorderSide(color: Color(0xFF4CAF50)),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'CLEAR ALL',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Obx(() => ElevatedButton(
              onPressed: controller.isApplyingFilter.value
                  ? null
                  : controller.applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: controller.isApplyingFilter.value
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'APPLYING...',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
                  : Text(
                'APPLY',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
