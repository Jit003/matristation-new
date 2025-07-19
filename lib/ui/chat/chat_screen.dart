import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';
import '../../controller/chat_controller.dart';
import 'chat_item_card.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar:CustomAppBarWidget(title: 'Chat'),
      body: Column(
        children: [
          _buildTabBar(),
          _buildFilterBar(), // Added filter bar
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
          Tab(text: 'Live Response'),
          Tab(text: 'Calls'),
        ],
      ),
    );
  }

  // Added filter bar widget
  Widget _buildFilterBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Filter:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Obx(() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.filterOptions.asMap().entries.map((entry) {
                  int index = entry.key;
                  String filter = entry.value;
                  bool isSelected = controller.selectedFilterIndex.value == index;

                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => controller.selectFilter(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF4CAF50) : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? Color(0xFF4CAF50) : Colors.grey[300]!,
                            width: 1,
                          ),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: Color(0xFF4CAF50).withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ] : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected) ...[
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                            ],
                            Text(
                              filter,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey[700],
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )),
          ),
          // Filter count badge
          Obx(() {
            int filteredCount = controller.getFilteredData().length;
            int totalCount = controller.getCurrentTabData().length;

            if (controller.selectedFilterIndex.value == 0 || filteredCount == totalCount) {
              return SizedBox.shrink();
            }

            return Container(
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF4CAF50).withOpacity(0.3),
                ),
              ),
              child: Text(
                '$filteredCount/$totalCount',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: controller.tabController,
      children: [
        _buildChatList(),
        _buildChatList(),
        _buildCallList(),
      ],
    );
  }

  Widget _buildChatList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50)));
      }

      // Use filtered data instead of raw data
      List<ChatItem> chatData = controller.getFilteredData();

      if (chatData.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          return ChatItemCard(
            chatItem: chatData[index],
            onTap: () => controller.onChatTap(chatData[index]),
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

      // Use filtered data instead of raw data
      List<ChatItem> callData = controller.getFilteredData();

      if (callData.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: callData.length,
        itemBuilder: (context, index) {
          return ChatItemCard(
            chatItem: callData[index],
            onTap: () => controller.onChatTap(callData[index]),
            onCallTap: () => controller.onCallTap(callData[index].id),
            showCallButton: true,
          );
        },
      );
    });
  }

  Widget _buildEmptyState() {
    return Obx(() {
      String emptyMessage = controller.selectedFilterIndex.value == 0
          ? 'No chats yet'
          : 'No ${controller.filterOptions[controller.selectedFilterIndex.value].toLowerCase()} chats found';

      String emptySubMessage = controller.selectedFilterIndex.value == 0
          ? 'Start a conversation with someone special'
          : 'Try selecting a different filter option';

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              emptySubMessage,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            if (controller.selectedFilterIndex.value != 0) ...[
              SizedBox(height: 16),
              TextButton(
                onPressed: () => controller.selectFilter(0),
                child: Text(
                  'Clear Filter',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}

// Search Delegate
class ChatSearchDelegate extends SearchDelegate<String> {
  final ChatController controller;

  ChatSearchDelegate(this.controller);

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
        child: Text('Search for chats by name'),
      );
    }

    List<ChatItem> searchResults = controller.getCurrentTabData()
        .where((item) =>
        item.name.toLowerCase().contains(query.toLowerCase()))
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
        return ChatItemCard(
          chatItem: searchResults[index],
          onTap: () {
            close(Get.context!, '');
            controller.onChatTap(searchResults[index]);
          },
        );
      },
    );
  }
}