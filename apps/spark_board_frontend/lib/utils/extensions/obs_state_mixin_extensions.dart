import 'package:dio/dio.dart';
import 'package:obs_state_mixin/obs_state_mixin.dart';

extension ObsStateMixinExt on ObsStateMixin {
  /// Get dio cancel token that will be cancelled on dispose.
  CancelToken cancelToken() {
    final cancelToken = CancelToken();
    onDispose(cancelToken.cancel);
    return cancelToken;
  }
}
