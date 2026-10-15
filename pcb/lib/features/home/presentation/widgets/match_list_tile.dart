import 'package:flutter/material.dart';

class MatchListTile extends StatelessWidget {
  const MatchListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('Match Title'),
      subtitle: Text('Date & Venue'),
    );
  }
}
