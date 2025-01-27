import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/common.dart';
import 'project_bar_state.dart';

class ProjectBarView extends CoraConsumerView<ProjectBarState> {
  const ProjectBarView({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  ProjectBarState createState() => ProjectBarState();

  @override
  Widget build(BuildContext context, ProjectBarState state) {
    final isLightMode = state.watch(
      themeProvider.select((s) => s.mode == ThemeMode.light),
    );
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const Spacer(),

          // theme button
          IconButton(
            tooltip: isLightMode ? 'Dark mode' : 'Light mode',
            onPressed: () => state.read(themeProvider.notifier).toggle(),
            icon: Icon(
              isLightMode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
          ),

          // profile
          const _ProfileIcon(),
        ],
      ),
    );
  }
}

class _ProfileIcon extends StatefulWidget {
  const _ProfileIcon();

  @override
  State<_ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<_ProfileIcon> {
  final _controller = OverlayPortalController();
  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _layerLink,
            followerAnchor: Alignment.topRight,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
              alignment: Alignment.topRight,
              child: TapRegion(
                onTapOutside: (_) => _controller.hide(),
                child: _buildCard(context),
              ),
            ),
          );
        },
        child: IconButton(
          onPressed: _controller.show,
          icon: const Icon(Icons.account_circle),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
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
      },
    );
  }
}
