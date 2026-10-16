import 'package:flutter/material.dart';

import '../../../core/widgets/dark_page.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'English';

  @override
  Widget build(BuildContext context) {
    const languages = ['English', 'Urdu', 'Punjabi'];
    return DarkPage(
      title: 'Language',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: languages.map((lang) {
          final selected = lang == _selected;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              onTap: () => setState(() => _selected = lang),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: selected
                      ? const Color(0xFF00C853)
                      : const Color(0xFF24332D),
                ),
              ),
              tileColor: const Color(0xFF0F1C18),
              title: Text(lang, style: const TextStyle(color: Colors.white)),
              trailing: Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? const Color(0xFF00C853) : Colors.white24,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
