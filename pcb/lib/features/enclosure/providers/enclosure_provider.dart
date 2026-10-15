import 'package:flutter/foundation.dart';
import '../data/models/enclosure_model.dart';

class EnclosureProvider extends ChangeNotifier {
  List<EnclosureModel> _enclosures = [];
  bool _isLoading = false;

  List<EnclosureModel> get enclosures => _enclosures;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setEnclosures(List<EnclosureModel> enclosures) {
    _enclosures = enclosures;
    notifyListeners();
  }
}
