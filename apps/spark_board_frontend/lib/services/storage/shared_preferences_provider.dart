import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/common.dart';

part 'shared_preferences_provider.g.dart';

/// Shared preferences provider.
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}
