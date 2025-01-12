import '../utils/common.dart';
import '../utils/themes.dart';

part 'theme_provider.g.dart';

typedef ThemeState = ({ThemeMode mode, ThemeData light, ThemeData dark});

@riverpod
class Theme extends _$Theme {
  @override
  ThemeState build() {
    return (
      mode: ThemeMode.system,
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
  }
}
