import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/home/profile_stats_section_screen.dart';
import '../../controller/home_controller.dart';

class ProfileStatsSection extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Obx(() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(controller.profileStats.length, (index) {
            final stat = controller.profileStats[index];
            return GestureDetector(
              onTap:(){ Get.to(()=>ProfileStatsSectionScreen(label: stat.label,));},
              child: Container(
                width: 100,
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        stat.icon,
                        color: stat.color,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${stat.label} (${stat.count})',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      )),
    );
  }
}
