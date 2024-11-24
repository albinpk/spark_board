import '../../utils/common.dart';
import 'dashboard_view.dart';

/// State for [DashboardView].
class DashboardState extends CoraConsumerState<DashboardView> {
  Future<void> onLogout() async {
    await ref.storage.clear();
    go(const LoginRoute().location);
  }
}
