class MoneyFormatter {
  MoneyFormatter._();

  static String format(double value) {
    String formatted = value.toStringAsFixed(2).replaceAll('.', ',');
    int size = formatted.length - 3;
    while (size > 3) {
      size -= 3;
      formatted =
          '${formatted.substring(0, size)}.${formatted.substring(size)}';
    }
    return 'R\$ $formatted';
  }
}
