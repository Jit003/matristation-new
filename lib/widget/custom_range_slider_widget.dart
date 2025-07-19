import 'package:flutter/material.dart';

class CustomSliderWidget extends StatelessWidget {
  final String title;
  final double min;
  final double max;
  final double value;
  final String unit;
  final ValueChanged<double> onChanged;

  const CustomSliderWidget({
    Key? key,
    required this.title,
    required this.min,
    required this.max,
    required this.value,
    required this.unit,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 10),

        // Value Display
        Center(
          child: Text(
            "${value.toStringAsFixed(0)} $unit",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),

        // Slider
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.pink,
          inactiveColor: Colors.grey.withOpacity(0.3),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
