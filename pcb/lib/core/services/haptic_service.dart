import 'package:flutter/services.dart';

class HapticService {
  const HapticService._();

  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  static Future<void> selectionClick() async {
    await HapticFeedback.selectionClick();
  }
}
