import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dark_back_button.dart';

class DarkPage extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const DarkPage({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    const DarkBackButton(),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: actions == null
                          ? const SizedBox(width: 40)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: actions!,
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
