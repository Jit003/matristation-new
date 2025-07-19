import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/filter/filter_screen.dart';
import 'package:matri_station/widget/custom_app_bar_other_page.dart';

class ProfileStatsSectionScreen extends StatelessWidget {
  final String label;
  const ProfileStatsSectionScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: label,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FilterScreen());
              },
              icon: Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
              ))
        ],
      ),

    );
  }
}
