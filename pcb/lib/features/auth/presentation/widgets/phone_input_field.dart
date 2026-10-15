import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const PhoneInputField({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141A18), // Clean flat solid dark surface
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF2A3632), // Solid neutral border
          width: 1.2,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          // Pakistan Flag & Country code
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2623), // Flat solid neutral
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '🇵🇰',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 8),
                Text(
                  '+92',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Vertical solid divider
          Container(
            height: 24,
            width: 1,
            color: const Color(0xFF2A3632),
          ),
          const SizedBox(width: 12),
          // Input field
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              onChanged: onChanged,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
              cursorColor: const Color(0xFF00C853),
              decoration: InputDecoration(
                hintText: '300 1234567',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
