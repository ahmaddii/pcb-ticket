import 'package:flutter/material.dart';

class CapacityBar extends StatelessWidget {
  final double percentage;

  const CapacityBar({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final value = (percentage / 100.0).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 7,
        backgroundColor: const Color(0xFF1A2C26),
        color: const Color(0xFF00C853),
      ),
    );
  }
}
