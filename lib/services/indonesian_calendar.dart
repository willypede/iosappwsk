import 'package:intl/intl.dart';

class IndonesianCalendar {

  static String convert(String currentDate){
    if(currentDate == null || currentDate.isEmpty)
      return "";
    final DateFormat format = new DateFormat("yyyy-MM-dd");
    final DateFormat newFormat = new DateFormat("dd MMM yyyy");
    final oldDate = format.parse(currentDate);
    final newDate = newFormat.format(oldDate);
    return newDate;
  }
  static String convertToDateTime(String currentDate){
    if(currentDate == null || currentDate.isEmpty)
      return "";
    final DateTime dateTime = DateTime.parse(currentDate);
    final DateFormat newFormat = new DateFormat("dd MMM yyyy, HH:mm");
    final newDate = newFormat.format(dateTime);
    return newDate;
  }
  static String convertToDdM(String currentDate){
    if(currentDate == null || currentDate.isEmpty)
      return "";
    final DateTime dateTime = DateTime.parse(currentDate);
    final DateFormat newFormat = new DateFormat("d/M");
    final newDate = newFormat.format(dateTime);
    return newDate;
  }
}