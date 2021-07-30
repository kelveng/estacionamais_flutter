class DateTimeUtils {
  static String getDateText(DateTime dateTime) {
    final String ret =
        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString()} ';
    return ret;
  }

  static String getHourDate(DateTime dateTime) {
    final String ret =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return ret;
  }
}
