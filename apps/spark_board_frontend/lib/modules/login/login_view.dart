import '../../utils/common.dart';
import 'login_state.dart';

/// Route: [LoginRoute].
class LoginView extends CoraConsumerView<LoginState> {
  const LoginView({
    super.key,
    this.nextRoute,
    this.isDemo = false,
  });

  /// The route to navigate to after login
  final String? nextRoute;

  /// If true, the form will be pre-filled with demo credentials.
  final bool isDemo;

  @override
  Widget build(BuildContext context, LoginState state) {
    return WebTitle(
      title: 'Login',
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                // left side
                if (constraints.maxWidth > 600)
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.cs.secondary,
                            context.cs.primary,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'SparkBoard',
                          style: context.displaySmall.copyWith(
                            color: context.cs.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),

                // right - form
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(Margin.xLarge),
                        child: Form(
                          key: state.form,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              vertical: Margin.xLarge,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Hello Again!',
                                  style: context.titleLarge,
                                ),
                                H.xLarge,

                                // email
                                TextFormField(
                                  controller: state.emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                  ),
                                  validator: FormBuilderValidators.email(),
                                ),
                                H.xLarge,

                                // password
                                TextFormField(
                                  controller: state.passwordController,
                                  obscureText: !state.showPassword.value,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      onPressed: state.showPassword.toggle,
                                      icon: Icon(
                                        state.showPassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.required(),
                                ),

                                // error message
                                if (state.error.value != null) ...[
                                  H.large,
                                  Text(
                                    state.error.value!,
                                    style: context.bodyMedium.copyWith(
                                      color: context.cs.error,
                                    ),
                                  ),
                                ],

                                H.xLarge,

                                // login button
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: state.onLogin,
                                    child: state.isLoading.value
                                        ? SizedBox.square(
                                            dimension: 20,
                                            child: CircularProgressIndicator(
                                              color: context.cs.onPrimary,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text('Login'),
                                  ),
                                ),
                                H.medium,

                                if (false)
                                  LinkText(
                                    [
                                      ("Don't have an account? ", null),
                                      (
                                        'Sign up',
                                        () => state
                                            .go(const SignupRoute().location),
                                      ),
                                    ],
                                    style: context.bodySmall,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  LoginState createState() => LoginState();
}
