import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/match_controller.dart';
import '../profile/match_widget/profile_card.dart';

class CasteDetailScreen extends StatelessWidget {
  final MatchController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildStateTabs(),
          Expanded(child: _buildProfileList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: controller.searchController,
          onChanged: controller.onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search in selected caste...',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildStateTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Obx(() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.states.map((state) {
            final isSelected = controller.selectedState.value == state;
            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(state),
                selected: isSelected,
                onSelected: (selected) {
                  controller.selectState(state);
                },
                selectedColor: const Color(0xFF4CAF50).withOpacity(0.2),
                checkmarkColor: const Color(0xFF4CAF50),
                backgroundColor: Colors.grey[100],
                side: BorderSide(
                  color: isSelected ? const Color(0xFF4CAF50) : Colors.grey[300]!,
                ),
              ),
            );
          }).toList(),
        ),
      )),
    );
  }

  Widget _buildProfileList() {
    return Obx(() {
      if (controller.isLoadingProfiles.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF4CAF50),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.profiles.length,
        itemBuilder: (context, index) {
          return ProfileCard(profile: controller.profiles[index]);
        },
      );
    });
  }
}
