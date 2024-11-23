import '../../utils/common.dart';
import 'signup_state.dart';

class SignupView extends CoraConsumerView<SignupState> {
  const SignupView({super.key});

  @override
  SignupState createState() => SignupState();

  @override
  Widget build(BuildContext context, SignupState state) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            state.go(const LoginRoute().location);
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
