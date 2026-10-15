class Validators {
  const Validators._();

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.trim().length != 6) {
      return 'Enter a valid 6-digit OTP';
    }
    return null;
  }
}
