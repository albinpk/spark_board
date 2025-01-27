import '../../utils/common.dart';
import 'project_details_state.dart';

class ProjectDetailsView extends CoraConsumerView<ProjectDetailsState> {
  const ProjectDetailsView({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  ProjectDetailsState createState() => ProjectDetailsState();

  @override
  Widget build(BuildContext context, ProjectDetailsState state) {
    return WebTitle(
      title: 'Project',
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton(
                onPressed: () {
                  TasksRoute(projectId: projectId).go(context);
                },
                child: const Text('Open Board'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
