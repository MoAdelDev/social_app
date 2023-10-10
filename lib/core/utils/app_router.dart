import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/modules/authentication/presentation/screens/login_screen.dart';
import 'package:social_app/modules/authentication/presentation/screens/register_screen.dart';
import 'package:social_app/modules/home/presentation/screens/home_screen.dart';

abstract class AppRouter {
  static const kLoginScreen = '/login';
  static const kRegisterScreen = '/register';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            FirebaseAuth.instance.currentUser?.uid != null
                ? const HomeScreen()
                : const LoginScreen(),
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
