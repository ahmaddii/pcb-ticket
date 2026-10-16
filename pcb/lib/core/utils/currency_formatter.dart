class CurrencyFormatter {
  const CurrencyFormatter._();

  static String withCommas(num amount) {
    final digits = amount.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  static String formatPKR(num amount) {
    return 'PKR ${withCommas(amount)}';
  }
}
