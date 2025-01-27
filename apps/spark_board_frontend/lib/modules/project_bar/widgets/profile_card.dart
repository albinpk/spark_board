import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/common.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    if (user == null) return const SizedBox.shrink();

    final isDarkMode = ref.watch(
      themeProvider.select((s) => s.mode == ThemeMode.dark),
    );
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 5,
        child: ListTileTheme(
          iconColor: context.grey(0.6),
          dense: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              H.large,
              CircleAvatar(
                backgroundColor: context.grey(0.05),
                child: const Icon(Icons.person),
              ),
              H.medium,
              Text(
                user.name,
                style: context.titleMedium,
              ),
              Text(user.email),
              H.medium,
              ListTile(
                title: const Text('Dark mode'),
                onTap: () => ref.read(themeProvider.notifier).toggle(),
                leading: const Icon(Icons.dark_mode_outlined),
                trailing: Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: isDarkMode,
                    onChanged: (_) => ref.read(themeProvider.notifier).toggle(),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () => ref.read(userProvider.notifier).logout(),
                leading: const Icon(Icons.logout),
              ),
              H.medium,
            ],
          ),
        ),
      ),
    );
  }
}
