/// Api endpoints.
abstract final class Endpoints {
  static const _v1 = '/v1';

  static const login = '$_v1/auth/login';

  static const projects = '$_v1/projects';

  static const tasks = '$_v1/projects/{projectId}/tasks';

  static const task = '$_v1/projects/{projectId}/tasks/{taskId}';

  static const staffs = '$_v1/staff';

  static const staff = '$_v1/staff/{staffId}';
}
