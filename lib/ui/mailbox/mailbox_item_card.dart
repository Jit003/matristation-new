import 'package:flutter/material.dart';
import '../../controller/mailbox_controller.dart';

class MailboxItemCard extends StatelessWidget {
  final MailboxItem item;
  final VoidCallback onTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onCallTap;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final bool showRequestActions;
  final bool showCallAction;

  const MailboxItemCard({
    Key? key,
    required this.item,
    required this.onTap,
    this.onMessageTap,
    this.onCallTap,
    this.onAccept,
    this.onDecline,
    this.showRequestActions = false,
    this.showCallAction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: item.profileImage.isNotEmpty
                              ? Image.network(
                            item.profileImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Color(0xFF4CAF50),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              );
                            },
                          )
                              : Container(
                            color: Color(0xFF4CAF50),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      // Online indicator
                      if (item.isOnline)
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

                  // Profile Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E50),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _buildStatusChip(),
                          ],
                        ),

                        SizedBox(height: 4),

                        // ID and Age
                        Row(
                          children: [
                            Text(
                              'ID: ${item.id}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '•',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${item.age} years',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 4),

                        // Profession
                        Text(
                          item.profession,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 4),

                        // Address
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.address,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        // Message preview
                        Text(
                          item.message,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Timestamp
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.timestamp,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  _buildActionButtons(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    String statusText = item.status.toUpperCase();

    switch (item.status.toLowerCase()) {
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'accepted':
        chipColor = Colors.green;
        break;
      case 'declined':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: chipColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    if (showRequestActions) {
      return Row(
        children: [
          if (item.status == 'pending') ...[
            _buildActionButton(
              'Accept',
              Colors.green,
              onAccept ?? () {},
            ),
            SizedBox(width: 8),
            _buildActionButton(
              'Decline',
              Colors.red,
              onDecline ?? () {},
            ),
          ],
        ],
      );
    }

    if (showCallAction) {
      return _buildActionButton(
        'Call',
        Color(0xFF4CAF50),
        onCallTap ?? () {},
        icon: Icons.phone,
      );
    }

    return _buildActionButton(
      'Message',
      Color(0xFF4CAF50),
      onMessageTap ?? () {},
      icon: Icons.message,
    );
  }

  Widget _buildActionButton(
      String text,
      Color color,
      VoidCallback onPressed, {
        IconData? icon,
      }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: color),
              SizedBox(width: 4),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}