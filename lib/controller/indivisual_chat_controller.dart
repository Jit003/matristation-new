import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../ui/chat/audio_screen.dart';

class IndividualChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Observable variables
  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;
  var isTyping = false.obs;
  var isSending = false.obs;
  var chatItem = ChatItem(
    id: '',
    name: '',
    lastMessage: '',
    timestamp: '',
    unreadCount: 0,
    profileImage: '',
    isOnline: false,
    lastSeen: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      chatItem.value = Get.arguments as ChatItem;
      loadMessages();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // Load messages
  Future<void> loadMessages() async {
    isLoading.value = true;
    try {
      // TODO: Replace with actual API call
      await Future.delayed(Duration(seconds: 1));
      loadMockMessages();
      _scrollToBottom();
    } catch (e) {
      print('Error loading messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Mock messages
  void loadMockMessages() {
    messages.value = [
      ChatMessage(
        id: 'msg001',
        message: 'Hi there! How are you doing today?',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        isSentByMe: false,
        isRead: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: 'msg002',
        message: 'Hello! I am doing great, thank you for asking. How about you?',
        timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 58)),
        isSentByMe: true,
        isRead: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: 'msg003',
        message: 'I am good too! I saw your profile and found it very interesting. Would love to know more about you.',
        timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
        isSentByMe: false,
        isRead: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: 'msg004',
        message: 'Thank you so much! I would love to know more about you as well. What do you do for work?',
        timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 25)),
        isSentByMe: true,
        isRead: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: 'msg005',
        message: 'I work as a software engineer at a tech company. What about you?',
        timestamp: DateTime.now().subtract(Duration(minutes: 45)),
        isSentByMe: false,
        isRead: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: 'msg006',
        message: 'That sounds interesting! I am a doctor at a local hospital.',
        timestamp: DateTime.now().subtract(Duration(minutes: 40)),
        isSentByMe: true,
        isRead: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: 'msg007',
        message: 'Wow, that\'s amazing! Would you like to have a call sometime?',
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        isSentByMe: false,
        isRead: false,
        messageType: MessageType.text,
      ),
    ];
  }

  // Send message
  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    isSending.value = true;

    ChatMessage newMessage = ChatMessage(
      id: 'msg${DateTime.now().millisecondsSinceEpoch}',
      message: messageController.text.trim(),
      timestamp: DateTime.now(),
      isSentByMe: true,
      isRead: false,
      messageType: MessageType.text,
    );

    messages.add(newMessage);
    messageController.clear();
    _scrollToBottom();

    // TODO: Send message via API

    // Simulate sending delay
    Future.delayed(Duration(milliseconds: 500), () {
      isSending.value = false;
      // Simulate typing indicator and response
      _simulateResponse();
    });
  }

  // Simulate typing and response
  void _simulateResponse() {
    isTyping.value = true;

    Future.delayed(Duration(seconds: 2), () {
      isTyping.value = false;

      List<String> responses = [
        'That sounds great!',
        'Thanks for your message!',
        'I appreciate you reaching out.',
        'Looking forward to talking more.',
        'That\'s very interesting!',
      ];

      ChatMessage response = ChatMessage(
        id: 'msg${DateTime.now().millisecondsSinceEpoch}',
        message: responses[DateTime.now().millisecond % responses.length],
        timestamp: DateTime.now(),
        isSentByMe: false,
        isRead: false,
        messageType: MessageType.text,
      );

      messages.add(response);
      _scrollToBottom();
    });
  }

  // Scroll to bottom
  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Handle audio call
  void onAudioCallTap() {
    // Get.to(() => AudioCallScreen());
  }

  // Handle video call
  void onVideoCallTap() {
    // Get.to(() => VideoCallScreen(chatItem: chatItem.value));
  }

  // Handle profile tap
  void onProfileTap() {
    Get.toNamed('/profile-details', arguments: chatItem.value.id);
  }

  // Handle menu actions
  void onMenuAction(String action) {
    switch (action) {
      case 'profile':
        onProfileTap();
        break;
      case 'block':
        _showBlockDialog();
        break;
      case 'report':
        _showReportDialog();
        break;
      case 'clear':
        _showClearChatDialog();
        break;
    }
  }

  void _showBlockDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Block User'),
        content: Text('Are you sure you want to block ${chatItem.value.name}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Implement block user
              Get.snackbar('Blocked', '${chatItem.value.name} has been blocked');
            },
            child: Text('Block', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Report User'),
        content: Text('Are you sure you want to report ${chatItem.value.name}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Implement report user
              Get.snackbar('Reported', '${chatItem.value.name} has been reported');
            },
            child: Text('Report', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showClearChatDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Clear Chat'),
        content: Text('Are you sure you want to clear this chat?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              messages.clear();
              Get.snackbar('Cleared', 'Chat has been cleared');
            },
            child: Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Enhanced Chat Message Model
class ChatMessage {
  final String id;
  final String message;
  final DateTime timestamp;
  final bool isSentByMe;
  final bool isRead;
  final MessageType messageType;
  final String? imageUrl;
  final String? audioUrl;
  final int? audioDuration;

  ChatMessage({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.isSentByMe,
    required this.isRead,
    required this.messageType,
    this.imageUrl,
    this.audioUrl,
    this.audioDuration,
  });
}

enum MessageType { text, image, audio, video }

// Chat Item Model (if not already defined)
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