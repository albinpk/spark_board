import 'package:flutter/material.dart';
import 'package:flutter_cora_riverpod/flutter_cora_riverpod.dart';

import 'tasks_state.dart';

class TasksView extends CoraConsumerView<TasksState> {
  const TasksView({super.key});

  @override
  TasksState createState() => TasksState();

  @override
  Widget build(BuildContext context, TasksState state) {
    return const Scaffold(
      body: Center(
        child: Text('Tasks'),
      ),
    );
  }
}
