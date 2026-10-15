class AuthRepository {
  Future<void> sendOtp(String phone) async {}
  Future<bool> verifyOtp(String phone, String otp) async => true;
}
