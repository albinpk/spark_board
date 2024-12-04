import '../../../utils/common.dart';

/// Status of a task
enum TaskStatus {
  todo(Colors.purple),
  inProgress(Colors.orange),
  done(Colors.green);

  const TaskStatus(this.color);

  /// Converts string to [TaskStatus] enum.
  factory TaskStatus.fromName(String name) =>
      TaskStatus.values.firstWhere((e) => e.name == name);

  final Color color;
}
