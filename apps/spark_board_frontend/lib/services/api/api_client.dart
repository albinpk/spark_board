import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'endpoints.dart';
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
}
