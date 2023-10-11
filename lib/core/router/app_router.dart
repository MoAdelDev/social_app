import 'package:flutter/material.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/modules/authentication/presentation/screens/login_screen.dart';
import 'package:social_app/modules/authentication/presentation/screens/register_screen.dart';
import 'package:social_app/modules/home/presentation/screens/home_screen.dart';
import 'package:social_app/modules/publish/presentation/screens/publish_screen.dart';

class AppRouter {
  static const kLoginScreen = '/login';
  static const kRegisterScreen = '/register';
  static const kPublishScreen = '/publish';
  static const kHomeScreen = '/home';

  static AppRouter getInstance() => AppRouter();

  Route? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.kLoginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case AppRouter.kRegisterScreen:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case AppRouter.kPublishScreen:
        var args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (context) => PublishScreen(args: args),
        );
      case AppRouter.kHomeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
