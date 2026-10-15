import 'package:flutter/material.dart';

class CapacityBar extends StatelessWidget {
  final double percentage;

  const CapacityBar({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (percentage / 100.0).clamp(0.0, 1.0),
    );
  }
}
