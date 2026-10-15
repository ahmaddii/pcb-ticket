import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final Duration duration;

  const CountdownTimer({
    super.key,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      duration.toString().split('.').first,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
