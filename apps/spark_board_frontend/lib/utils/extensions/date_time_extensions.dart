import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  /// Returns formatted date string.
  String format() => DateFormat('dd MMM yyyy').format(this);
}
