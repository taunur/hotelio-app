import 'package:intl/intl.dart';

class AppFormat {
  static String date(String stringDate) {
    // 2022-02-05
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy', 'id').format(dateTime); // 5 Feb 2022
  }

  static String dateMonth(String stringDate) {
    // 2022-02-05
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM', 'id').format(dateTime); // 5 Feb
  }

  static String currency(double number) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
    ).format(number);
  }
}
