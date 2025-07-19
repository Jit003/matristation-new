import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/subscription_plan_model.dart';

class SubscriptionController extends GetxController {
  var isLoading = false.obs;
  var plans = <SubscriptionPlan>[].obs;
  var selectedPlanId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  void fetchPlans() {
    isLoading.value = true;

    // Simulate API call with delay
    Future.delayed(const Duration(milliseconds: 500), () {
      plans.value = [
        SubscriptionPlan(
          id: '1',
          name: 'Gold',
          duration: '3 Months',
          originalPrice: 5000,
          discountedPrice: 3500,
          discountPercentage: '30% OFF!',
          isBestSeller: false,
          isBestValue: false,
          features: [
            'Valid for 3 months',
            'View limited contact Nos*',
            'Send limited messages',
            'Basic horoscope views',
            'View verified profiles'
          ],
          validityMessage: 'Valid for today',
          pricePerMonth: '₹1,167 per month',
          isSelected: false,
        ),
        SubscriptionPlan(
          id: '2',
          name: 'Prime Gold',
          duration: '3 Months',
          originalPrice: 7500,
          discountedPrice: 4600,
          discountPercentage: '39% OFF!',
          isBestSeller: true,
          isBestValue: false,
          features: [
            'Valid for 3 months',
            'View unlimited contact Nos*',
            'Send unlimited messages',
            'Unlimited horoscope views',
            'View verified profiles with photos'
          ],
          validityMessage: 'Valid for today',
          pricePerMonth: '₹1,533 per month',
          isSelected: true,
        ),
        SubscriptionPlan(
          id: '3',
          name: 'Till U Marry',
          duration: 'Lifetime',
          originalPrice: 15000,
          discountedPrice: 4800,
          discountPercentage: '68% OFF',
          isBestSeller: false,
          isBestValue: true,
          features: [
            'Valid until you get married',
            'View unlimited contact Nos*',
            'Send unlimited messages',
            'Unlimited horoscope views',
            'View verified profiles with photos',
            'Priority customer support',
            'Profile boost every month'
          ],
          validityMessage: 'Best long-term value',
          pricePerMonth: '₹400 per month',
          isSelected: false,
        ),
      ];

      // Set the initially selected plan
      selectedPlanId.value = '2'; // Prime Gold

      isLoading.value = false;
    });
  }

  void selectPlan(String planId) {
    if (selectedPlanId.value == planId) return;

    selectedPlanId.value = planId;

    final updatedPlans = plans.map((plan) {
      return plan.copyWith(isSelected: plan.id == planId);
    }).toList();

    plans.value = updatedPlans;
  }

  SubscriptionPlan? get selectedPlan {
    if (plans.isEmpty) return null;
    try {
      return plans.firstWhere((plan) => plan.id == selectedPlanId.value);
    } catch (e) {
      return plans.first;
    }
  }

  void proceedToPayment() {
    // Implement payment logic here
    Get.snackbar(
      'Processing Payment',
      'Processing payment for ${selectedPlan?.name} plan',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }
}
