import '../utils/common.dart';
import '../utils/themes.dart';

part 'theme_provider.g.dart';

typedef ThemeState = ({ThemeMode mode, ThemeData light, ThemeData dark});

@riverpod
class Theme extends _$Theme {
  @override
  ThemeState build() {
    final mode = ref.storage.getString(StorageConstants.themeMode);
    return (
      mode: mode == ThemeMode.dark.name ? ThemeMode.dark : ThemeMode.light,
      dark: AppTheme.dark(),
      light: AppTheme.light(),
    );
  }

  void toggle() {
    state = (
      mode: state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
      dark: state.dark,
      light: state.light
    );
    ref.storage.setString(StorageConstants.themeMode, state.mode.name);
  }
}
