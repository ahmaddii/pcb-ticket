import 'package:flutter/material.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03140F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF03140F),
        elevation: 0,
        title: const Text(
          'My Match Tickets',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'Your active match passes and QR codes will appear here.',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
