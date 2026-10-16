import 'package:flutter/material.dart';

import '../../../core/widgets/dark_page.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const faqs = [
      (
        'How do I enter the stadium?',
        'Show your QR ticket at the assigned gate. Keep a valid CNIC with you.'
      ),
      (
        'Can I change enclosure?',
        'Enclosure changes depend on availability before the match start.'
      ),
      (
        'What if payment fails?',
        'No ticket is issued until payment succeeds. Retry from checkout.'
      ),
    ];

    return DarkPage(
      title: 'Help & Support',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          ...faqs.map(
            (faq) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1C18),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF24332D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faq.$1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    faq.$2,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.55),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Need more help? Email tickets@pcb.com.pk',
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
