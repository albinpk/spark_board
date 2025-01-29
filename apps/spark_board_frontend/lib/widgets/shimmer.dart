import 'package:flutter/foundation.dart';

import '../utils/common.dart';

class Shimmer<T> extends StatelessWidget {
  const Shimmer({
    required this.value,
    required this.mock,
    required this.builder,
    this.ignoreContainers,
    super.key,
  });

  final AsyncValue<T> value;
  final T mock;
  final Widget Function(T data) builder;
  final bool? ignoreContainers;

  @override
  Widget build(BuildContext context) {
    final value = this.value.unwrapPrevious();
    final data = value.valueOrNull ?? mock;

    if (value.hasError) {
      return Center(
        child: kDebugMode
            ? Text(
                value.error.toString(),
                style: context.bodyMedium.copyWith(
                  color: context.cs.error,
                ),
              )
            : Text(
                'Something went wrong',
                style: context.bodyMedium.fade(),
              ),
      );
    }

    return Skeletonizer(
      enabled: value.isLoading,
      ignoreContainers: ignoreContainers,
      child: builder(data),
    );
  }
}
