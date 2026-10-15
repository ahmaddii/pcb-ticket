import 'package:flutter/foundation.dart';
import '../data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }
}
