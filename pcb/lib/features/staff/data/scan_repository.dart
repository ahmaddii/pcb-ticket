import 'models/scan_result_model.dart';

class ScanRepository {
  Future<ScanResultModel> verifyTicket(String qrData) async {
    return ScanResultModel(
      isValid: true,
      ticketId: qrData,
      message: 'Valid Ticket',
      timestamp: DateTime.now(),
    );
  }
}
