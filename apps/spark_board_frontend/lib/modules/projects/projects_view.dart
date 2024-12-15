import '../../providers/projects_provider.dart';
import '../../utils/common.dart';
import 'projects_state.dart';

class ProjectsView extends CoraConsumerView<ProjectsState> {
  const ProjectsView({super.key});

  @override
  ProjectsState createState() => ProjectsState();

  @override
  Widget build(BuildContext context, ProjectsState state) {
    return WebTitle(
      title: 'Projects',
      child: Scaffold(
        appBar: AppBar(title: const Text('Projects')),
        body: state.watch(projectsProvider).when(
              loading: () => const Text('Loading..'),
              error: (error, stackTrace) => Text('$error'),
              data: (data) => Center(
                child: SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final p in data)
                        ListTile(
                          onTap: () {
                            ProjectDetailsRoute(projectId: p.projectId)
                                .go(context);
                          },
                          title: Text(p.name),
                          trailing: const Icon(Icons.arrow_right),
                        ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
