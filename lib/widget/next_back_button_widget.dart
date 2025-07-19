import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String nextText;
  final String backText;
  final bool isNextEnabled;

  const NavigationButtons({
    Key? key,
    required this.onNext,
    required this.onBack,
    this.nextText = "Next",
    this.backText = "Back",
    this.isNextEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        OutlinedButton.icon(
          onPressed: onBack,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            side: const BorderSide(color: Colors.blueAccent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blueAccent, size: 18),
          label: Text(
            backText,
            style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
        ),

        // Next Button
        ElevatedButton(
          onPressed: isNextEnabled ? onNext : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isNextEnabled ? Colors.blueAccent : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: Row(
            children: [
              Text(
                nextText,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
