import 'package:intl/intl.dart';

// function: that parse my value publishedAt on my Data
String dtParser(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);

  final format = DateFormat('yyyy-MM-dd hh:mm');
  final dt = format.format(dateTime);
  return dt;
}
