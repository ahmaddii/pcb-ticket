import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const PaymentMethodTile({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}
