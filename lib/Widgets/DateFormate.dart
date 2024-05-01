import 'package:intl/intl.dart';

String currentDate() {
  DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
  String currentDate = dateFormat.format(DateTime.now());
  return currentDate;
}
