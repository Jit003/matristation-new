class SubscriptionPlan {
  final String id;
  final String name;
  final String duration;
  final double originalPrice;
  final double discountedPrice;
  final String discountPercentage;
  final bool isBestSeller;
  final bool isBestValue;
  final List<String> features;
  final String validityMessage;
  final String pricePerMonth;
  final bool isSelected;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.duration,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    this.isBestSeller = false,
    this.isBestValue = false,
    required this.features,
    required this.validityMessage,
    required this.pricePerMonth,
    this.isSelected = false,
  });

  SubscriptionPlan copyWith({
    String? id,
    String? name,
    String? duration,
    double? originalPrice,
    double? discountedPrice,
    String? discountPercentage,
    bool? isBestSeller,
    bool? isBestValue,
    List<String>? features,
    String? validityMessage,
    String? pricePerMonth,
    bool? isSelected,
  }) {
    return SubscriptionPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      originalPrice: originalPrice ?? this.originalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      isBestValue: isBestValue ?? this.isBestValue,
      features: features ?? this.features,
      validityMessage: validityMessage ?? this.validityMessage,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
