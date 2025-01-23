import '../utils/common.dart';

class Shimmer<T> extends StatelessWidget {
  const Shimmer({
    required this.value,
    required this.mock,
    required this.builder,
    super.key,
  });

  final AsyncValue<T> value;
  final T mock;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) {
    final data = value.valueOrNull ?? mock;
    // TODO(albin): error
    if (value.hasError) return const Text('error');
    return Skeletonizer(
      enabled: value.isLoading,
      child: builder(data),
    );
  }
}
