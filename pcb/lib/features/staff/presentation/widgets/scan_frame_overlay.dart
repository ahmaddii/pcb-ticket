import 'package:flutter/material.dart';

class ScanFrameOverlay extends StatelessWidget {
  const ScanFrameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
