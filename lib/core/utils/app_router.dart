
import 'package:go_router/go_router.dart';
import 'package:social_app/modules/authentication/presentation/screens/login_screen.dart';
import 'package:social_app/modules/authentication/presentation/screens/register_screen.dart';

abstract class AppRouter {
  static const kLoginScreen = '/login';
  static const kRegisterScreen = '/register';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kRegisterScreen,
        builder: (context, state) => RegisterScreen(),
      ),
    ],
  );
}
