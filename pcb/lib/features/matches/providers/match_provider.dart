import 'package:flutter/foundation.dart';
import '../data/models/match_model.dart';

class MatchProvider extends ChangeNotifier {
  List<MatchModel> _matches = [];
  bool _isLoading = false;

  List<MatchModel> get matches => _matches;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setMatches(List<MatchModel> matches) {
    _matches = matches;
    notifyListeners();
  }
}
