import 'package:flutter/material.dart';

class ScanResultCard extends StatelessWidget {
  final bool isValid;
  final String message;

  const ScanResultCard({
    super.key,
    required this.isValid,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isValid ? Colors.green.shade50 : Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isValid ? Icons.check_circle : Icons.cancel,
              color: isValid ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
