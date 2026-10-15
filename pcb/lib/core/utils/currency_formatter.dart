class CurrencyFormatter {
  const CurrencyFormatter._();

  static String formatPKR(num amount) {
    return 'PKR ${amount.toStringAsFixed(0)}';
  }
}
