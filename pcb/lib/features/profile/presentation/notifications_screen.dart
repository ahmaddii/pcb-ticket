import 'package:flutter/material.dart';

import '../../../core/widgets/dark_page.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Tickets confirmed', 'Pakistan vs New Zealand · General Enclosure'),
      ('Gates open reminder', 'Arrive 2 hours before play at Gate 3'),
      ('Offer', '10% off Premium Enclosure this weekend'),
    ];

    return DarkPage(
      title: 'Notifications',
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1C18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF24332D)),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_active_outlined,
                    color: Color(0xFF00C853)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        item.$2,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
