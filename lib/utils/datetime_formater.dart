import 'package:intl/intl.dart';

class DateTimeFormater {
  static String formatDate(DateTime date) {
    return DateFormat('E, MMM d • h:mm a').format(date).toUpperCase() + " EDT";
  }
}
