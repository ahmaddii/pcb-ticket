import 'package:flutter/material.dart';

import '../../../core/widgets/dark_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _matchAlerts = true;
  bool _gateReminders = true;
  bool _offers = false;

  @override
  Widget build(BuildContext context) {
    return DarkPage(
      title: 'Settings',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          _toggle('Match alerts', _matchAlerts, (v) {
            setState(() => _matchAlerts = v);
          }),
          _toggle('Gate opening reminders', _gateReminders, (v) {
            setState(() => _gateReminders = v);
          }),
          _toggle('Offers & promotions', _offers, (v) {
            setState(() => _offers = v);
          }),
        ],
      ),
    );
  }

  Widget _toggle(String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1C18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF24332D)),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        value: value,
        activeThumbColor: Colors.white,
        activeTrackColor: const Color(0xFF00C853),
        onChanged: onChanged,
      ),
    );
  }
}
