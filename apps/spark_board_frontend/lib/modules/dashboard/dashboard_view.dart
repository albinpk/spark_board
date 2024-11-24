import '../../utils/common.dart';
import 'dashboard_state.dart';

/// Route [DashboardRoute].
class DashboardView extends CoraConsumerView<DashboardState> {
  const DashboardView({super.key});

  @override
  DashboardState createState() => DashboardState();

  @override
  Widget build(BuildContext context, DashboardState state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: TextButton(
          onPressed: state.onLogout,
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
