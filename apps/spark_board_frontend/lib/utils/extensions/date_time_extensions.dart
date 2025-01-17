import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  /// Returns formatted date string.
  String format([String pattern = 'dd MMM yyyy']) =>
      DateFormat(pattern).format(this);
}
