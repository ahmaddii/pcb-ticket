import 'package:flutter/material.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03140F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF03140F),
        elevation: 0,
        title: const Text(
          'All Fixtures & Matches',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'Tournament fixtures and series matches will be listed here.',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
