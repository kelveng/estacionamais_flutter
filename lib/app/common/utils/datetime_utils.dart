class DateTimeUtils {
  static String getDateText(DateTime dateTime) {
    final String ret =
        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString()} ';
    return ret;
  }
}
