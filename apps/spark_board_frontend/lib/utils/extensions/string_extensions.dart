/// Extensions for string.
extension StringExt on String {
  /// Returns null if string is empty.
  String? get nullIfEmpty => isEmpty ? null : this;
}
