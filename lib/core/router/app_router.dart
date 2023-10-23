import 'package:flutter/material.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/modules/authentication/presentation/screens/login_screen.dart';
import 'package:social_app/modules/authentication/presentation/screens/register_screen.dart';
import 'package:social_app/modules/home/presentation/screens/home_screen.dart';
import 'package:social_app/modules/home/presentation/screens/modify_post_screen.dart';
import 'package:social_app/modules/home/presentation/screens/publish_post_screen.dart';

class AppRouter {
  static const kLoginScreen = '/login';
  static const kRegisterScreen = '/register';
  static const kPublishScreen = '/publish';
  static const kModifyPostScreen = '/modify_post';
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
          builder: (context) => const RegisterScreen(),
        );
      case AppRouter.kPublishScreen:
        var args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (context) => PublishPostScreen(args: args),
        );
      case AppRouter.kModifyPostScreen:
        var args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (context) => ModifyPostScreen(args: args),
        );
      case AppRouter.kHomeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
    return null;
  }
}
