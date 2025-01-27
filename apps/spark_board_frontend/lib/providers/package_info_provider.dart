import 'package:package_info_plus/package_info_plus.dart';

import '../utils/common.dart';

part 'package_info_provider.g.dart';

@riverpod
Future<PackageInfo> packageInfo(Ref ref) async {
  final info = await PackageInfo.fromPlatform();
  ref.keepAlive();
  return info;
}
