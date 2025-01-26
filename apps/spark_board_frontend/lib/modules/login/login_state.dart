import '../../utils/common.dart';
import 'login_view.dart';

/// State for [LoginView].
class LoginState extends CoraConsumerState<LoginView> with ObsStateMixin {
  final form = GlobalKey<FormState>();
  late final emailController = TextEditingController(
    text: widget.isDemo ? 'albin@mail.com' : null,
  );
  late final passwordController = TextEditingController(
    text: widget.isDemo ? '12345678' : null,
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late final showPassword = obs(false);
  late final isLoading = obs(false);
  late final error = obs<String?>(null);

  Future<void> onLogin() async {
    if (isLoading.value) return;

    if (!form.currentState!.validate()) return;
    isLoading.setTrue();
    final (err, data) = await ref.api.login(
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    ).go();
    isLoading.setFalse();

    if (err != null || data?.data.token == null) {
      error.value = err;
      return;
    }

    await ref.storage.setString(StorageConstants.token, data!.data.token);
    go(widget.nextRoute ?? const ProjectsRoute().location);
  }
}
