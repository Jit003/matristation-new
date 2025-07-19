import 'package:flutter/material.dart';
import '../../controller/chat_controller.dart';

class ChatItemCard extends StatelessWidget {
  final ChatItem chatItem;
  final VoidCallback onTap;
  final VoidCallback? onCallTap;
  final bool showCallButton;

  const ChatItemCard({
    Key? key,
    required this.chatItem,
    required this.onTap,
    this.onCallTap,
    this.showCallButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Image with Online Indicator
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.grey[300]!, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: chatItem.profileImage.isNotEmpty
                          ? Image.network(
                        chatItem.profileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xFF4CAF50),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 28,
                            ),
                          );
                        },
                      )
                          : Container(
                        color: Color(0xFF4CAF50),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  // Online indicator
                  if (chatItem.isOnline)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(width: 12),

              // Chat Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Timestamp
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            chatItem.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C3E50),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          chatItem.timestamp,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),

                    // Last Message and Unread Count
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              if (chatItem.isTyping) ...[
                                Text(
                                  'typing...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4CAF50),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ] else if (chatItem.callType != null) ...[
                                Icon(
                                  chatItem.callType == 'missed'
                                      ? Icons.call_missed
                                      : chatItem.callType == 'video'
                                      ? Icons.videocam
                                      : Icons.call,
                                  size: 16,
                                  color: chatItem.callType == 'missed'
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    chatItem.lastMessage,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ] else ...[
                                Expanded(
                                  child: Text(
                                    chatItem.lastMessage,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                      fontWeight: chatItem.unreadCount > 0
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Unread Count Badge
                        if (chatItem.unreadCount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFF4CAF50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chatItem.unreadCount.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        // Call Button
                        if (showCallButton && onCallTap != null)
                          GestureDetector(
                            onTap: onCallTap,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF4CAF50).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.phone,
                                size: 20,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}