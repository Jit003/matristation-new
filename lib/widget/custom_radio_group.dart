import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRadioGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final RxString selectedValue;

  const CustomRadioGroup({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Wrap(
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: selectedValue.value,
                  onChanged: (value) {
                    selectedValue.value = value!;
                  },
                  activeColor: const Color(0xFF4CAF50),
                ),
                Text(option),
                const SizedBox(width: 16),
              ],
            );
          }).toList(),
        )),
      ],
    );
  }
}
