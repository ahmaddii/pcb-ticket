import 'package:flutter/material.dart';

import '../../../core/widgets/dark_page.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const methods = [
      (Icons.bolt_rounded, Color(0xFFFB923C), 'JazzCash / Easypaisa'),
      (Icons.credit_card_rounded, Color(0xFF60A5FA), 'Visa / Mastercard'),
      (Icons.account_balance_rounded, Color(0xFFA78BFA), 'Bank transfer'),
    ];

    return DarkPage(
      title: 'Payment Methods',
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        itemCount: methods.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final method = methods[index];
          return ListTile(
            tileColor: const Color(0xFF0F1C18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFF24332D)),
            ),
            leading: Icon(method.$1, color: method.$2),
            title: Text(
              method.$3,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Text(
              'Ready',
              style: TextStyle(color: Color(0xFF00C853), fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
