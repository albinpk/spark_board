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
              // const ListTile(
              //   title: Text('Profile'),
              //   leading: Icon(Icons.person_outline),
              // ),
              // const ListTile(
              //   title: Text('Settings'),
              //   leading: Icon(Icons.settings_outlined),
              // ),
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
