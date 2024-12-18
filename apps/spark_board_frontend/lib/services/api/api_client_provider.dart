import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../utils/common.dart';
import 'api_client.dart';
import 'endpoints.dart';

part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final authToken = ref.storage.getString('token');
        if (authToken != null) {
          options.headers['Authorization'] = 'Bearer $authToken';
        }
        return handler.next(options);
      },
    ),
  );

  if (kDebugMode) {
    dio.interceptors.addAll([
      CurlLoggerDioInterceptor(printOnSuccess: true),
      PrettyDioLogger(requestBody: true),
    ]);
  }

  return ApiClient(dio, baseUrl: Endpoints.baseUrl);
}
