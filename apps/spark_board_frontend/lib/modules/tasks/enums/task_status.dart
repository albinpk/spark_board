import '../../../utils/common.dart';

/// Status of a task
enum TaskStatus {
  todo(Colors.purple, 'To do'),
  inProgress(Colors.orange, 'In progress'),
  done(Colors.green, 'Done');

  const TaskStatus(this.color, this.label);

  /// Converts string to [TaskStatus] enum.
  factory TaskStatus.fromName(String name) =>
      TaskStatus.values.firstWhere((e) => e.name == name);

  final Color color;
  final String label;
}
