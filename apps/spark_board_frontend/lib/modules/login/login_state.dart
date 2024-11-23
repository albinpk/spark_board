import '../../route/routes.dart';
import '../../utils/common.dart';
import 'login_view.dart';

/// State for [LoginView].
class LoginState extends CoraConsumerState<LoginView> with ObsStateMixin {
  final form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late final showPassword = obs(false);

  void onLogin() {
    if (!form.currentState!.validate()) return;
    // TODO(albin): api integration
    go(const SignupRoute().location);
  }
}
