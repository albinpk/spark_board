import 'dart:math';

import '../../providers/projects_provider.dart';
import '../../services/api/models/projects_response.dart';
import '../../utils/common.dart';
import 'models/project_more_option_enum.dart';
import 'projects_state.dart';
import 'widget/create_project_dialog.dart';

/// Route: [ProjectsRoute].
class ProjectsView extends CoraConsumerView<ProjectsState> {
  const ProjectsView({super.key});

  @override
  ProjectsState createState() => ProjectsState();

  // for skeleton
  static final _mock = Data(
    projectId: '1',
    name: BoneMock.fullName,
    description: BoneMock.address,
    createdAt: mockDate,
  );

  @override
  Widget build(BuildContext context, ProjectsState state) {
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Shimmer(
                      value: state.watch(projectsProvider),
                      ignoreContainers: false,
                      mock: _mock.asList(2),
                      builder: (projects) {
                        if (projects.isEmpty) {
                          return Center(
                            child: Text(
                              'No projects found',
                              style: context.bodyMedium.fade(),
                            ),
                          );
                        }
                        return GridView.builder(
                          controller: state.scrollController,
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
                            return _buildCard(
                              context,
                              projects[index],
                              state,
                            );
                          },
                        );
                      },
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

  Widget _buildCard(BuildContext context, Data project, ProjectsState state) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () {
          ProjectDetailsRoute(
            projectId: project.projectId,
          ).go(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Margin.xLarge,
            horizontal: Margin.xxLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project.name,
                      style: context.titleMedium,
                    ),
                  ),
                  PopupMenuButton<ProjectMoreOption>(
                    icon: const Icon(Icons.more_vert),
                    iconColor: context.grey(),
                    onSelected: (value) =>
                        _onProjectOption(value, project, state, context),
                    itemBuilder: (context) {
                      return ProjectMoreOption.values
                          .map(
                            (e) => PopupMenuItem(
                              value: e,
                              child: Text(e.name.capitalize),
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              ),
              H.large,
              Expanded(
                child: Text(
                  project.description ?? '',
                  overflow: TextOverflow.fade,
                  style: context.bodyMedium.fade(0.7),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project.createdAt.format('MMM d, yyyy'),
                      style: context.bodySmall.copyWith(
                        color: context.cs.onSurface.fade(0.5),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: context.cs.onSurface.fade(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onProjectOption(
    ProjectMoreOption option,
    Data project,
    ProjectsState state,
    BuildContext context,
  ) async {
    switch (option) {
      case ProjectMoreOption.delete:
        final confirmed = await confirmDialog(
          context: context,
          description: 'Are you sure you want to delete this project?\n'
              'All tasks in this project will also be deleted.',
        );
        if (confirmed) await state.deleteProject(project);
    }
  }
}
