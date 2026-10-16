import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_names.dart';
import '../../enclosure/data/enclosure_catalog.dart';
import '../../enclosure/presentation/widgets/enclosure_row.dart';

class MatchDetailsScreen extends StatefulWidget {
  final String team1;
  final String team2;
  final String format;
  final String venue;
  final DateTime dateTime;
  final String imageAsset;

  const MatchDetailsScreen({
    super.key,
    this.team1 = 'Pakistan',
    this.team2 = 'New Zealand',
    this.format = 'ODI',
    this.venue = 'Rawalpindi Cricket Stadium',
    required this.dateTime,
    this.imageAsset = AppAssets.stadiumSplash,
  });

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  int _tabIndex = 0;
  Timer? _timer;

  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final List<EnclosureOption> _enclosures = EnclosureCatalog.all;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final weekday = _weekdays[date.weekday - 1];
    final month = _months[date.month - 1];
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final isPm = hour >= 12;
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$weekday, ${date.day} $month ${date.year}  •  $hour12:$minute ${isPm ? 'PM' : 'AM'}';
  }

  String _timeLeftLabel(DateTime target) {
    final diff = target.difference(DateTime.now());
    if (diff.isNegative) return 'Started';
    if (diff.inDays >= 1) {
      return '${diff.inDays}d ${diff.inHours.remainder(24)}h';
    }
    return '${diff.inHours}h ${diff.inMinutes.remainder(60)}m';
  }

  List<String> _venueLines(String venue) {
    final parts = venue.split(',').map((part) => part.trim()).toList();
    if (parts.length >= 2) {
      return [parts.first, parts.sublist(1).join(', ')];
    }
    const suffix = 'Cricket Stadium';
    if (venue.endsWith(suffix) && venue.length > suffix.length) {
      return [venue.substring(0, venue.length - suffix.length).trim(), suffix];
    }
    return [venue, 'Match venue'];
  }

  void _openEnclosure(EnclosureOption enclosure) {
    Navigator.of(context).pushNamed(
      RouteNames.enclosureSelection,
      arguments: {
        'team1': widget.team1,
        'team2': widget.team2,
        'format': widget.format,
        'venue': widget.venue,
        'dateTime': widget.dateTime,
        'matchImageAsset': widget.imageAsset,
        'enclosureId': enclosure.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final venueLines = _venueLines(widget.venue);
    final timeLeft = _timeLeftLabel(widget.dateTime);
    final matchStarted = widget.dateTime.isBefore(DateTime.now());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeroImage(
                        imageAsset: widget.imageAsset,
                        onBack: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        '${widget.team1} vs ${widget.team2}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${widget.format}  •  ${widget.venue}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.55),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xFF00C853),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _formatDate(widget.dateTime),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _InfoChip(
                              icon: Icons.location_on_outlined,
                              title: venueLines.first,
                              subtitle: venueLines.length > 1
                                  ? venueLines[1]
                                  : 'Stadium',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _InfoChip(
                              icon: Icons.schedule_outlined,
                              title: timeLeft,
                              subtitle: matchStarted
                                  ? 'Match underway'
                                  : 'Left to match',
                              titleColor: const Color(0xFF00C853),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      _TabStrip(
                        selectedIndex: _tabIndex,
                        onChanged: (index) {
                          setState(() => _tabIndex = index);
                        },
                      ),
                      const SizedBox(height: 16),
                      if (_tabIndex == 0)
                        ..._enclosures.map(
                          (enclosure) => EnclosureRow(
                            name: enclosure.name,
                            price: enclosure.price,
                            availableSeats: enclosure.availableSeats,
                            imageAsset: enclosure.coverAsset,
                            onTap: () => _openEnclosure(enclosure),
                          ),
                        )
                      else
                        _AboutTab(
                          team1: widget.team1,
                          team2: widget.team2,
                          format: widget.format,
                          venue: widget.venue,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String imageAsset;
  final VoidCallback onBack;

  const _HeroImage({
    required this.imageAsset,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 210,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF0F261E),
                  child: const Icon(
                    Icons.sports_cricket,
                    color: Color(0xFF00C853),
                    size: 48,
                  ),
                );
              },
            ),
            Positioned(
              top: 12,
              left: 12,
              child: GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1A14).withValues(alpha: 0.78),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2A3632)),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? titleColor;

  const _InfoChip({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1C18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF24332D), width: 1.1),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00C853), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: titleColor ?? Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabStrip extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _TabStrip({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabLabel(
          label: 'Enclosures',
          selected: selectedIndex == 0,
          onTap: () => onChanged(0),
        ),
        const SizedBox(width: 28),
        _TabLabel(
          label: 'About',
          selected: selectedIndex == 1,
          onTap: () => onChanged(1),
        ),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabLabel({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? Colors.white : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              label,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.45),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  final String team1;
  final String team2;
  final String format;
  final String venue;

  const _AboutTab({
    required this.team1,
    required this.team2,
    required this.format,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1C18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF24332D), width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$format fixture at $venue',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$team1 take on $team2 in a packed $format contest. Choose your enclosure, complete booking, and enter with a digital ticket.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Good to know',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          _bullet('Gates open 2 hours before play'),
          _bullet('Valid CNIC required at entry'),
          _bullet('Outside food and beverages are not allowed'),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: Color(0xFF00C853)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
