import 'package:intl/intl.dart';

// these all basically to convert date & time from calendar to string
class DateConverter {
  static String getDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String getDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    return formattedDate;
  }

  String formatDate2(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formattedDate = DateFormat('dd MMM, yyyy');
    return formattedDate.format(dateTime);
  }

  DateTime intToDate(int dateInt) {
    String intToStringDate = dateInt.toString();
    DateTime date = DateTime.parse(intToStringDate);
    // bool compareDate = dateTime.isAtSameMomentAs(DateTime.now());
    return date;
  }

  static String getTime(int time) {
    switch (time) {
      case 0:
        return '10:30 AM';
      case 1:
        return '11:30 AM';
      case 2:
        return '12:30 AM';
      case 3:
        return '13:30 PM';
      case 4:
        return '14:30 PM';
      case 5:
        return '15:30 PM';
      case 6:
        return '16:30 PM';
      case 7:
        return '17:30 PM';
      case 8:
        return '18:30 PM';
      case 9:
        return '19:30 PM';
      default:
        return '10:30 AM';
    }
  }
}
