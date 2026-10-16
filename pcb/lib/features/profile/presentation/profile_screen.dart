import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/router/route_names.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
            children: [
              const Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1C18),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF24332D)),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFF00C853),
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ahmad Rasheed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '+92 300 1234567',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _ProfileTile(
                icon: Icons.confirmation_number_outlined,
                title: 'My Tickets',
                subtitle: 'Wallet and QR passes',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.myTickets);
                },
              ),
              _ProfileTile(
                icon: Icons.history_rounded,
                title: 'Booking History',
                subtitle: 'Past and upcoming orders',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.bookingHistory);
                },
              ),
              _ProfileTile(
                icon: Icons.payments_outlined,
                title: 'Payment Methods',
                subtitle: 'JazzCash, cards and banks',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.paymentMethods);
                },
              ),
              _ProfileTile(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle: 'Match and gate alerts',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.notifications);
                },
              ),
              _ProfileTile(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'Alerts and preferences',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.settings);
                },
              ),
              _ProfileTile(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: 'English, Urdu, Punjabi',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.language);
                },
              ),
              _ProfileTile(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                subtitle: 'FAQs and contact',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.helpSupport);
                },
              ),
              _ProfileTile(
                icon: Icons.logout_rounded,
                title: 'Sign out',
                subtitle: 'Return to fan login',
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteNames.login,
                    (route) => route.isFirst,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1C18),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF24332D)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF00C853), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white38),
            ],
          ),
        ),
      ),
    );
  }
}
