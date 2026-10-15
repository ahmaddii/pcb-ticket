import 'package:flutter/foundation.dart';
import '../data/models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  BookingModel? _currentBooking;
  bool _isLoading = false;

  BookingModel? get currentBooking => _currentBooking;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setBooking(BookingModel? booking) {
    _currentBooking = booking;
    notifyListeners();
  }
}
