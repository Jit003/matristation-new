import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/utility/constant.dart';
import '../../controller/match_controller.dart';
import '../../widget/custom_dropdown.dart';
import '../profile/match_widget/animated_text_container.dart';
import '../profile/match_widget/profile_card.dart';

class MatchScreen extends StatelessWidget {
  final MatchController controller = Get.put(MatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildToggleTabs(),
          _buildFilterButtons(),
          _buildCasteButtons(),
          Expanded(child: _buildProfileList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      elevation: 2,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          controller: controller.searchController,
          onChanged: controller.onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search profiles...',
            suffixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (!controller.isStateMode.value) {
                              controller.toggleMode();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.isStateMode.value
                                  ? const Color(0xFF4CAF50)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'States',
                                style: TextStyle(
                                  color: controller.isStateMode.value
                                      ? Colors.white
                                      : Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (controller.isStateMode.value) {
                              controller.toggleMode();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: !controller.isStateMode.value
                                  ? const Color(0xFF4CAF50)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'Castes',
                                style: TextStyle(
                                  color: !controller.isStateMode.value
                                      ? Colors.white
                                      : Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          const SizedBox(width: 16),
          _buildStatesCastesList(),
        ],
      ),
    );
  }

  Widget _buildStatesCastesList() {
    return Obx(() {
      final items =
          controller.isStateMode.value ? controller.states : controller.castes;
      final selectedItem = controller.isStateMode.value
          ? controller.selectedState.value
          : controller.selectedCaste.value;

      return Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(25),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedItem,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: (String? newValue) {
              if (newValue != null) {
                if (controller.isStateMode.value) {
                  controller.selectState(newValue);
                  if (newValue != 'All') {
                    controller.openStateDetailScreen();
                  }
                } else {
                  controller.selectCaste(newValue);
                  if (newValue != 'All') {
                    controller.openCasteDetailScreen();
                  }
                }
              }
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildFilterButtons() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.matchTypeButtons.map((type) {
                final isSelected = controller.selectedMatchType.value == type;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (selected) {
                      controller.selectMatchType(type);
                    },
                    selectedColor: const Color(0xFF4CAF50).withOpacity(0.2),
                    checkmarkColor: const Color(0xFF4CAF50),
                    backgroundColor: Colors.grey[100],
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey[300]!,
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }

  Widget _buildAnimatedContainer() {
    return AnimatedTextContainer(controller: controller);
  }

  Widget _buildCasteButtons() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.casteButtons.map((caste) {
                final isSelected = controller.selectedCaste.value == caste;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(caste),
                    selected: isSelected,
                    onSelected: (selected) {
                      controller.selectCaste(caste);
                    },
                    selectedColor: Colors.purple.withOpacity(0.2),
                    checkmarkColor: Colors.purple,
                    backgroundColor: Colors.grey[100],
                    side: BorderSide(
                      color: isSelected ? Colors.purple : Colors.grey[300]!,
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

      if (controller.profiles.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No profiles found',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your filters',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
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
