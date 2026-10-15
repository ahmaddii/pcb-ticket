import 'package:flutter/foundation.dart';
import '../data/models/scan_result_model.dart';

class ScannerProvider extends ChangeNotifier {
  ScanResultModel? _lastResult;
  bool _isScanning = false;

  ScanResultModel? get lastResult => _lastResult;
  bool get isScanning => _isScanning;

  void setScanning(bool scanning) {
    _isScanning = scanning;
    notifyListeners();
  }

  void setResult(ScanResultModel? result) {
    _lastResult = result;
    notifyListeners();
  }
}
