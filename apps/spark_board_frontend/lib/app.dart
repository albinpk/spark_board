import 'route/router.dart';
import 'utils/app_snackbar.dart';
import 'utils/common.dart';
import 'utils/themes.dart';

/// Root widget.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AppSnackbar.key,
      routerConfig: ref.watch(appRouterProvider),
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
    );
  }
}
