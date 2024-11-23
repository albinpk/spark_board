import '../../utils/common.dart';
import 'login_state.dart';

/// Route: [LoginRoute].
class LoginView extends CoraConsumerView<LoginState> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, LoginState state) {
    return Scaffold(
      body: Row(
        children: [
          // left side
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
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: FormBuilderValidators.email(),
                          ),
                          H.xLarge,

                          // password
                          TextFormField(
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
                          H.xLarge,

                          // login button
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: state.onLogin,
                              child: const Text('Login'),
                            ),
                          ),
                          H.medium,

                          LinkText(
                            [
                              ("Don't have an account? ", null),
                              (
                                'Sign up',
                                () => state.go(const SignupRoute().location),
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
      ),
    );
  }

  @override
  LoginState createState() => LoginState();
}
