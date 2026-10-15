import 'package:flutter/material.dart';

class ReservationTimer extends StatelessWidget {
  final Duration remaining;

  const ReservationTimer({
    super.key,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      remaining.toString().split('.').first,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
