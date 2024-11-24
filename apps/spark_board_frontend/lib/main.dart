import 'app.dart';
import 'services/storage/shared_preferences_provider.dart';
import 'utils/common.dart';

Future<void> main() async {
  final container = ProviderContainer();
  await container.read(sharedPreferencesProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
