import 'package:flutter/material.dart';

class QrCard extends StatelessWidget {
  final String data;

  const QrCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text('QR Data: $data'),
        ),
      ),
    );
  }
}
