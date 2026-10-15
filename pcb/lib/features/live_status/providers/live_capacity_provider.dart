import 'package:flutter/foundation.dart';

class LiveCapacityProvider extends ChangeNotifier {
  double _currentCapacityPercentage = 0.0;
  bool _isLoading = false;

  double get currentCapacityPercentage => _currentCapacityPercentage;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void updateCapacity(double percentage) {
    _currentCapacityPercentage = percentage;
    notifyListeners();
  }
}
