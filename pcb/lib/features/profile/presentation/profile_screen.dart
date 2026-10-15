import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03140F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF03140F),
        elevation: 0,
        title: const Text(
          'My Profile & Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'User profile, payment methods, and preferences.',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
