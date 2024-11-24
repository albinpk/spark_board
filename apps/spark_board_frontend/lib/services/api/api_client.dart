import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'endpoints.dart';
import 'models/login_response.dart';

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
}
