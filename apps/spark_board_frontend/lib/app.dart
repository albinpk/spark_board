import 'providers/theme_provider.dart';
import 'route/router.dart';
import 'utils/common.dart';

/// Root widget.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AppSnackbar.key,
      title: 'SparkBoard',
      routerConfig: ref.watch(appRouterProvider),
      themeMode: theme.mode,
      theme: theme.light,
      darkTheme: theme.dark,
    );
  }
}
