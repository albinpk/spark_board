import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

extension DateTimeExt on DateTime {
  /// Returns formatted date string.
  String format([String pattern = 'dd MMM yyyy']) =>
      DateFormat(pattern).format(this);

  /// Returns formatted long date string.
  String formatLong() => format('dd MMM yyyy, hh:mm a');

  /// Returns relative date string.
  String fromNow() => Jiffy.parseFromDateTime(this).fromNow();
}
