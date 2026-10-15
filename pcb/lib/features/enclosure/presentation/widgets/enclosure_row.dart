import 'package:flutter/material.dart';

class EnclosureRow extends StatelessWidget {
  final String name;
  final double price;

  const EnclosureRow({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: Text('PKR ${price.toStringAsFixed(0)}'),
    );
  }
}
