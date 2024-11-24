import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../common.dart';

/// Response of a API call using [ApiResponseExtensions.go] method.
typedef Result<T> = (String? error, T? data);

/// Extension for retrofit http response.
extension ApiResponseExtensions<T> on Future<HttpResponse<T>> {
  /// Return API response as [Result] record; `(error, data)`.
  Future<Result<T>> go() async {
    try {
      return (null, (await this).data);
    } on DioException catch (e, st) {
      if (CancelToken.isCancel(e)) return const (null, null);
      if (e.response?.data case {'message': final String message}) {
        return (message, null);
      }
      L.shout('Api failed', e, st);
      return (e.message ?? 'Something went wrong', null);
    } catch (e, st) {
      L.shout('Api failed', e, st);
      return (e.toString(), null);
    }
  }
}
