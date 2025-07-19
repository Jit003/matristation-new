import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/match_controller.dart';

class AnimatedTextContainer extends StatelessWidget {
  final MatchController controller;

  const AnimatedTextContainer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4CAF50).withOpacity(0.8),
            const Color(0xFF8BC34A).withOpacity(0.8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child:  AnimatedBuilder(
          animation: controller.fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: controller.fadeAnimation.value,
              child: Text(
                controller.animatedTexts[controller.currentTextIndex.value],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
        )),

    );
  }
}
