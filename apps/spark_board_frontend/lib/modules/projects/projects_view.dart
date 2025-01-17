import 'dart:math';

import 'package:skeletonizer/skeletonizer.dart';

import '../../providers/projects_provider.dart';
import '../../services/api/models/projects_response.dart';
import '../../utils/common.dart';
import 'projects_state.dart';
import 'widget/create_project_dialog.dart';

/// Route: [ProjectsRoute].
class ProjectsView extends CoraConsumerView<ProjectsState> {
  const ProjectsView({super.key});

  @override
  ProjectsState createState() => ProjectsState();

  @override
  Widget build(BuildContext context, ProjectsState state) {
    // for skeleton
    final mock = Data(
      projectId: '1',
      name: BoneMock.fullName,
      description: BoneMock.address,
      createdAt: DateTime.now(),
    );

    final asyncValue = state.watch(projectsProvider);
    final projects = asyncValue.valueOrNull ?? [mock, mock];

    return WebTitle(
      title: 'Projects',
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.1,
          ).copyWith(top: 40),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Projects',
                      style: context.displaySmall,
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () => _onTapCreateProject(state),
                    icon: const Icon(Icons.add),
                    label: const Text('Create New'),
                  ),
                ],
              ),
              H.large,

              // grid
              Expanded(
                child: asyncValue.hasError
                    ? const Center(child: Text('Something went wrong!'))
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          return Skeletonizer(
                            enabled: !asyncValue.hasValue,
                            child: GridView.builder(
                              padding: const EdgeInsets.only(
                                top: Margin.large,
                                bottom: 60,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: max(
                                  1,
                                  constraints.maxWidth ~/ 300,
                                ),
                                mainAxisSpacing: Margin.xLarge,
                                mainAxisExtent: 150,
                                crossAxisSpacing: Margin.xLarge,
                              ),
                              itemCount: projects.length,
                              itemBuilder: (context, index) {
                                return _buildCard(context, projects[index]);
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapCreateProject(ProjectsState state) async {
    final result = await showDialog<CreateProjectDialogResult>(
      context: state.context,
      builder: (context) {
        return const Dialog(
          child: CreateProjectDialog(),
        );
      },
    );
    if (result == null) return;
    await state.createProject(result);
  }

  Widget _buildCard(BuildContext context, Data project) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () {
          ProjectDetailsRoute(
            projectId: project.projectId,
          ).go(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(Margin.xxLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: context.titleMedium,
              ),
              H.large,
              Expanded(
                child: Text(
                  project.description ?? '',
                  style: context.bodyMedium.copyWith(
                    color: context.cs.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project.createdAt.format('MMM d, yyyy'),
                      style: context.bodySmall.copyWith(
                        color: context.cs.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: context.cs.onSurface.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
