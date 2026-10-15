import 'package:flutter/material.dart';

class QuantityStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int>? onChanged;
  final int min;
  final int max;

  const QuantityStepper({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 1,
    this.max = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: value > min ? () => onChanged?.call(value - 1) : null,
        ),
        Text('$value', style: Theme.of(context).textTheme.titleMedium),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: value < max ? () => onChanged?.call(value + 1) : null,
        ),
      ],
    );
  }
}
