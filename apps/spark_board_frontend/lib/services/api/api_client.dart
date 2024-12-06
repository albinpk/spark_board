import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'endpoints.dart';
import 'models/create_task_response.dart';
import 'models/login_response.dart';
import 'models/projects_response.dart';
import 'models/tasks_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(
    Dio dio, {
    String baseUrl,
  }) = _ApiClient;

  @POST(Endpoints.login)
  Future<HttpResponse<LoginResponse>> login({
    @Body() required Map<String, dynamic> body,
  });

  @GET(Endpoints.projects)
  Future<HttpResponse<ProjectsResponse>> projects({
    @CancelRequest() required CancelToken cancelToken,
  });

  @GET(Endpoints.tasks)
  Future<HttpResponse<TasksResponse>> tasks({
    @Path('projectId') required String projectId,
    @CancelRequest() required CancelToken cancelToken,
  });

  @POST(Endpoints.tasks)
  Future<HttpResponse<CreateTaskResponse>> createTask({
    @Path('projectId') required String projectId,
    @Body() required Map<String, dynamic> body,
  });

  @DELETE(Endpoints.task)
  Future<HttpResponse<void>> deleteTask({
    @Path('projectId') required String projectId,
    @Path('taskId') required String taskId,
  });

  @PATCH(Endpoints.task)
  Future<HttpResponse<CreateTaskResponse>> updateTask({
    @Path('projectId') required String projectId,
    @Path('taskId') required String taskId,
    @Body() required Map<String, dynamic> body,
  });
}
