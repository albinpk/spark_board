import 'dart:developer' as dev;

extension LoggerExtensions<T> on T {
  /// Print object to console.
  T log([String name = 'dev']) {
    dev.log('$this', name: name);
    return this;
  }
}
