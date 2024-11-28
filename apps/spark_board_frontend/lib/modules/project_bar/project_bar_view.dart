import '../../providers/projects_provider.dart';
import '../../services/api/models/projects_response.dart';
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
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          // project switcher
          switch (state.watch(projectsProvider)) {
            AsyncData<List<Data>>(:final value) => PopupMenuButton<Data>(
                tooltip: 'Change Project',
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(Margin.medium),
                  child: Row(
                    children: [
                      Text(
                        value.firstWhere((e) => e.projectId == projectId).name,
                        style: context.titleMedium,
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
                onSelected: (value) {
                  TasksRoute(projectId: value.projectId).go(context);
                },
                itemBuilder: (context) => value
                    .map(
                      (e) => PopupMenuItem(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
              ),
            _ => const SizedBox.shrink(),
          },

          const Spacer(),

          // profile
          PopupMenuButton<int>(
            tooltip: 'Profile',
            padding: EdgeInsets.zero,
            menuPadding: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            child: const Padding(
              padding: EdgeInsets.all(Margin.small),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://picsum.photos/200',
                ),
              ),
            ),
            onSelected: (value) async {
              if (value == 1) {
                await state.ref.storage.clear();
                if (!context.mounted) return;
                const LoginRoute().go(context);
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
