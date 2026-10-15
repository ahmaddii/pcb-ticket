class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = 'https://api.pcb.com.pk/v1';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String matches = '/matches';
  static const String enclosures = '/enclosures';
  static const String bookings = '/bookings';
  static const String tickets = '/tickets';
  static const String scanTicket = '/staff/scan';
}
