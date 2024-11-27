import 'package:flutter/material.dart';
import 'package:flutter_cora_riverpod/flutter_cora_riverpod.dart';

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
    return Scaffold(
      body: Center(
        child: Text('Project $projectId'),
      ),
    );
  }
}
