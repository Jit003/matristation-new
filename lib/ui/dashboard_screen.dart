import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/chat/chat_screen.dart';
import 'package:matri_station/ui/home/home_screen.dart';
import 'package:matri_station/ui/mailbox/mailbox_screen.dart';
import 'package:matri_station/ui/match/match_screen.dart';
import 'package:matri_station/ui/profile/profile_screen.dart';
import '../controller/bottom_nav_controller.dart';
import '../widget/custom_bottom_nav_bar_widget.dart';


class DashboardScreen extends StatelessWidget {
  final navController = Get.put(BottomNavController());

  final screens = [
    HomeScreen(),
    MailboxScreen(),
    MatchScreen(),
    ChatScreen(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: screens[navController.selectedIndex.value],
        bottomNavigationBar: CustomBottomNavBar(),
      );
    });
  }
}
