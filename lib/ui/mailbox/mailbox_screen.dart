import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../../controller/mailbox_controller.dart';
import 'mailbox_item_card.dart';

class MailboxScreen extends StatelessWidget {
  final MailboxController controller = Get.put(MailboxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBarWidget(title: 'Mailbox',showBackButton: false,),
      body: Column(
        children: [
          _buildTabBar(),
          _buildFilterBar(),
          Expanded(child: _buildTabBarView()),
        ],
      ),
    );
  }


  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: controller.tabController,
        labelColor: Color(0xFF4CAF50),
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Color(0xFF4CAF50),
        indicatorWeight: 3,
        labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        tabs: [
          Tab(text: 'Received'),
          Tab(text: 'Sent'),
          Tab(text: 'Requests'),
          Tab(text: 'Calls'),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Obx(() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.filterOptions.asMap().entries.map((entry) {
            int index = entry.key;
            String filter = entry.value;
            bool isSelected = controller.selectedFilterIndex.value == index;

            return Padding(
              padding: EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => controller.selectFilter(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF4CAF50) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Color(0xFF4CAF50) : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      )),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: controller.tabController,
      children: [
        _buildMessageList(),
        _buildMessageList(),
        _buildRequestList(),
        _buildCallList(),
      ],
    );
  }

  Widget _buildMessageList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50)));
      }

      List<MailboxItem> filteredData = controller.getFilteredData();

      if (filteredData.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          return MailboxItemCard(
            item: filteredData[index],
            onTap: () => controller.onProfileTap(filteredData[index].id),
            onMessageTap: () => controller.onMessageTap(filteredData[index].id),
          );
        },
      );
    });
  }

  Widget _buildRequestList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50)));
      }

      List<MailboxItem> filteredData = controller.getFilteredData();

      if (filteredData.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          return MailboxItemCard(
            item: filteredData[index],
            showRequestActions: true,
            onTap: () => controller.onProfileTap(filteredData[index].id),
            onAccept: () => controller.acceptRequest(filteredData[index].id),
            onDecline: () => controller.declineRequest(filteredData[index].id),
          );
        },
      );
    });
  }

  Widget _buildCallList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50)));
      }

      List<MailboxItem> filteredData = controller.getFilteredData();

      if (filteredData.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          return MailboxItemCard(
            item: filteredData[index],
            showCallAction: true,
            onTap: () => controller.onProfileTap(filteredData[index].id),
            onCallTap: () => controller.onCallTap(filteredData[index].id),
          );
        },
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mail_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No messages found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start connecting with profiles to see messages here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Search Delegate
class MailboxSearchDelegate extends SearchDelegate<String> {
  final MailboxController controller;

  MailboxSearchDelegate(this.controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return Center(
        child: Text('Search for profiles by name or ID'),
      );
    }

    List<MailboxItem> searchResults = controller.getCurrentTabData()
        .where((item) =>
    item.name.toLowerCase().contains(query.toLowerCase()) ||
        item.id.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Text('No results found for "$query"'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return MailboxItemCard(
          item: searchResults[index],
          onTap: () {
            close(Get.context!, '');
            controller.onProfileTap(searchResults[index].id);
          },
        );
      },
    );
  }
}