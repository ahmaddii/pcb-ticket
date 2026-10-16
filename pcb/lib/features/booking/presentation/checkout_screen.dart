import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/router/route_names.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../tickets/data/ticket_store.dart';
import '../data/models/booking_flow_args.dart';

class CheckoutScreen extends StatefulWidget {
  final BookingFlowArgs booking;

  const CheckoutScreen({
    super.key,
    required this.booking,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _method = 'jazzcash';
  bool _paying = false;

  Future<void> _pay() async {
    setState(() => _paying = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final orderId =
        'PCB${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final confirmed = widget.booking.copyWith(orderId: orderId);
    TicketStore.instance.add(confirmed);
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.bookingSuccess,
      (route) =>
          route.settings.name == RouteNames.home || route.isFirst,
      arguments: confirmed.toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;
    final enclosure = booking.enclosure;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    DarkBackButton(),
                    Expanded(
                      child: Text(
                        'Payment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView(
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F1C18),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFF24332D)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    booking.matchImageAsset,
                                    width: 54,
                                    height: 54,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox(
                                        width: 54,
                                        height: 54,
                                        child: ColoredBox(
                                          color: Color(0xFF141A18),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${booking.team1} vs ${booking.team2}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        booking.venue,
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.5),
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        DateFormatter.formatMatchLine(
                                          booking.dateTime,
                                        ),
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.5),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            const Divider(color: Color(0xFF24332D), height: 1),
                            const SizedBox(height: 12),
                            _Line(
                              label: enclosure.name,
                              value:
                                  '${booking.ticketCount} x ${CurrencyFormatter.formatPKR(enclosure.price)}',
                            ),
                            const SizedBox(height: 8),
                            _Line(
                              label: 'Subtotal',
                              value: CurrencyFormatter.formatPKR(
                                booking.subtotal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _Line(
                              label: 'Service Fee',
                              value: CurrencyFormatter.formatPKR(
                                booking.serviceFee,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _Line(
                              label: 'Total',
                              value: CurrencyFormatter.formatPKR(booking.total),
                              emphasis: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _MethodTile(
                        id: 'jazzcash',
                        title: 'JazzCash / Easypaisa',
                        icon: Icons.bolt_rounded,
                        iconColor: const Color(0xFFFB923C),
                        selected: _method == 'jazzcash',
                        onTap: () => setState(() => _method = 'jazzcash'),
                      ),
                      _MethodTile(
                        id: 'card',
                        title: 'Card (Visa / Mastercard)',
                        icon: Icons.credit_card_rounded,
                        iconColor: const Color(0xFF60A5FA),
                        selected: _method == 'card',
                        onTap: () => setState(() => _method = 'card'),
                      ),
                      _MethodTile(
                        id: 'bank',
                        title: 'Other Banks',
                        icon: Icons.account_balance_rounded,
                        iconColor: const Color(0xFFA78BFA),
                        selected: _method == 'bank',
                        onTap: () => setState(() => _method = 'bank'),
                      ),
                    ],
                  ),
                ),
                GreenCtaButton(
                  label: 'Pay Now',
                  isLoading: _paying,
                  onPressed: _pay,
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, color: Colors.white38, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Secure Payment',
                      style: TextStyle(
                        color: Colors.white38,
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
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasis;

  const _Line({
    required this.label,
    required this.value,
    this.emphasis = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: emphasis ? Colors.white : Colors.white70,
              fontSize: emphasis ? 15 : 13,
              fontWeight: emphasis ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: emphasis ? 15 : 13,
            fontWeight: emphasis ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MethodTile extends StatelessWidget {
  final String id;
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool selected;
  final VoidCallback onTap;

  const _MethodTile({
    required this.id,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.selected,
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1C18),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? const Color(0xFF00C853) : const Color(0xFF24332D),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? const Color(0xFF00C853) : Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
