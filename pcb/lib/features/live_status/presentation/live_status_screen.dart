import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../enclosure/data/enclosure_catalog.dart';
import 'widgets/capacity_bar.dart';

class LiveStatusScreen extends StatelessWidget {
  const LiveStatusScreen({super.key});

  static const _stats = <String, _LiveStat>{
    'general': _LiveStat(entered: 1320),
    'first_class': _LiveStat(entered: 980),
    'premium': _LiveStat(entered: 640),
    'vip': _LiveStat(entered: 210),
  };

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Row(
                  children: [
                    if (Navigator.of(context).canPop()) ...[
                      const DarkBackButton(),
                      const SizedBox(width: 12),
                    ],
                    const Expanded(
                      child: Text(
                        'Live Enclosure Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                  itemCount: EnclosureCatalog.all.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final enclosure = EnclosureCatalog.all[index];
                    final stat = _stats[enclosure.id] ??
                        _LiveStat(entered: (enclosure.availableSeats * 0.5).round());
                    return _EnclosureStatusCard(
                      name: enclosure.name,
                      capacity: enclosure.availableSeats,
                      entered: stat.entered,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveStat {
  final int entered;
  const _LiveStat({required this.entered});
}

class _EnclosureStatusCard extends StatelessWidget {
  final String name;
  final int capacity;
  final int entered;

  const _EnclosureStatusCard({
    required this.name,
    required this.capacity,
    required this.entered,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = (capacity - entered).clamp(0, capacity);
    final percent = capacity == 0 ? 0.0 : (entered / capacity) * 100;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1C18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF24332D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Capacity: ${CurrencyFormatter.withCommas(capacity)}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: CapacityBar(percentage: percent)),
              const SizedBox(width: 10),
              Text(
                '${percent.round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '${CurrencyFormatter.withCommas(entered)} entered',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '${CurrencyFormatter.withCommas(remaining)} remaining',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.45),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
