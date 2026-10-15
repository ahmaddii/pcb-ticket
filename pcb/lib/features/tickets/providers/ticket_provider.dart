import 'package:flutter/foundation.dart';
import '../data/models/ticket_model.dart';

class TicketProvider extends ChangeNotifier {
  List<TicketModel> _tickets = [];
  bool _isLoading = false;

  List<TicketModel> get tickets => _tickets;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setTickets(List<TicketModel> tickets) {
    _tickets = tickets;
    notifyListeners();
  }
}
