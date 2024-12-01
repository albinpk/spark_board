import '../../../utils/common.dart';

/// Status of a task
enum TaskStatus {
  todo(Colors.purple),
  inProgress(Colors.orange),
  done(Colors.green);

  const TaskStatus(this.color);

  final Color color;
}
