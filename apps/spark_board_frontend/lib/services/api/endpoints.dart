/// Api endpoints.
abstract final class Endpoints {
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  static const _v1 = '/v1';

  static const login = '$_v1/auth/login';

  static const projects = '$_v1/projects';

  static const project = '$_v1/projects/{projectId}';

  static const tasks = '$_v1/projects/{projectId}/tasks';

  static const task = '$_v1/projects/{projectId}/tasks/{taskId}';

  static const taskAssign = '$_v1/projects/{projectId}/tasks/{taskId}/assign';

  static const taskComments =
      '$_v1/projects/{projectId}/tasks/{taskId}/comments';

  static const taskComment =
      '$_v1/projects/{projectId}/tasks/{taskId}/comments/{commentId}';

  static const staffs = '$_v1/staff';

  static const staff = '$_v1/staff/{staffId}';
}
