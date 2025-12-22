class MoneyFormatterUtils {
  MoneyFormatterUtils._();
  static String format(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}
