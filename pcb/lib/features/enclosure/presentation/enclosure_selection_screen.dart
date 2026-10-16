import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/router/route_names.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../booking/data/models/booking_flow_args.dart';
import '../data/enclosure_catalog.dart';
import 'widgets/stadium_map.dart';

class EnclosureSelectionScreen extends StatefulWidget {
  final BookingFlowArgs booking;

  const EnclosureSelectionScreen({
    super.key,
    required this.booking,
  });

  @override
  State<EnclosureSelectionScreen> createState() =>
      _EnclosureSelectionScreenState();
}

class _EnclosureSelectionScreenState extends State<EnclosureSelectionScreen> {
  late String _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.booking.enclosureId;
  }

  void _openDetails(String id) {
    Navigator.of(context).pushNamed(
      RouteNames.enclosureDetails,
      arguments: widget.booking.copyWith(enclosureId: id).toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    const DarkBackButton(),
                    const Expanded(
                      child: Text(
                        'Select Enclosure',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF141A18),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2A3632)),
                      ),
                      child: const Icon(
                        Icons.near_me_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF07160F),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFF24332D)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return InteractiveViewer(
                          minScale: 0.85,
                          maxScale: 3.4,
                          panEnabled: true,
                          scaleEnabled: true,
                          boundaryMargin: const EdgeInsets.all(80),
                          child: SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: StadiumMap(
                              selectedId: _selectedId,
                              onSelected: (id) {
                                if (_selectedId == id) {
                                  _openDetails(id);
                                } else {
                                  setState(() => _selectedId = id);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    'Pinch to zoom  ·  Drag to move around  ·  Tap a stand',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: EnclosureCatalog.all.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = EnclosureCatalog.all[index];
                      final selected = item.id == _selectedId;
                      return _EnclosurePickTile(
                        item: item,
                        selected: selected,
                        onTap: () {
                          setState(() => _selectedId = item.id);
                          _openDetails(item.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EnclosurePickTile extends StatelessWidget {
  final EnclosureOption item;
  final bool selected;
  final VoidCallback onTap;

  const _EnclosurePickTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = item.isLimited
        ? const Color(0xFFF3D03E)
        : const Color(0xFF00C853);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1C18),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? item.color : const Color(0xFF24332D),
              width: selected ? 1.6 : 1.1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      CurrencyFormatter.formatPKR(item.price),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.isLimited ? 'Limited' : 'Available',
                    style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${CurrencyFormatter.withCommas(item.availableSeats)}+',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
