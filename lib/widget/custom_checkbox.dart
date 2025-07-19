import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckboxGroup extends StatelessWidget {
  final String label;
  final RxBool value;

  const CustomCheckboxGroup({
    Key? key,
    required this.label,
    required this.value,
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
        Obx(() => Row(
          children: [
            Checkbox(
              value: value.value,
              onChanged: (newValue) {
                value.value = newValue!;
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            const Text('Yes'),
            const SizedBox(width: 16),
            Checkbox(
              value: !value.value,
              onChanged: (newValue) {
                value.value = !newValue!;
              },
              activeColor: const Color(0xFF4CAF50),
            ),
            const Text('No'),
          ],
        )),
      ],
    );
  }
}
