import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/home/prime_box.dart';
import 'package:matri_station/ui/home/profile_sections.dart';
import 'package:matri_station/ui/home/profile_stat_section.dart';
import 'package:matri_station/ui/home/service_section.dart';
import 'package:matri_station/ui/home/special_category_section.dart';
import '../../controller/home_controller.dart';
import '../../widget/home_header.dart';
import 'complete_profile_sections.dart';
import 'custom_footer.dart';
import 'marital_status_selector.dart';


class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 100; // Adjust if your header is taller

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // Scrollable content with padding for header
          Padding(
            padding: const EdgeInsets.only(top: headerHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() => controller.showPrimeBox.value
                      ? PrimeBox()
                      : SizedBox.shrink()),
                  MaritalStatusSelector(),
                  ProfileStatsSection(),
                  SpecialCategoriesSection(),
                  ProfileSections(),
                  CompleteProfileSection(),
                  ServicesSection(),
                  HomeFooter(),
                ],
              ),
            ),
          ),

          // Fixed Header at the top
          Container(
            height: headerHeight,
            width: double.infinity,
            color: Colors.white,
            child: HomeHeader(),
          ),
        ],
      ),
    );
  }
}
