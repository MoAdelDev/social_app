import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/services/service_locator.dart';
import 'package:social_app/core/style/colors.dart';
import 'package:social_app/core/style/themes.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart'
    as user_entity;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_app/modules/authentication/presentation/screens/login_screen.dart';
import 'package:social_app/modules/home/presentation/controller/home_bloc.dart';
import 'package:social_app/modules/home/presentation/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ServiceLocator().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static bool isDark = false;
  static bool isArabic = false;
  static user_entity.User? user;
  static Map<String, user_entity.User> postsUsers = {};

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColorDark.primary,
      ),
    );
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(
              sl(),
              sl(),
              sl(),
              sl(),
              sl(),
              sl(),
            )..add(const HomeGetPostsEvent()),
          ),
        ],
        child: MaterialApp(
          home: FirebaseAuth.instance.currentUser?.uid != null
              ? const HomeScreen()
              : const LoginScreen(),
          onGenerateRoute: (settings) =>
              AppRouter.getInstance().generateRouter(settings),
          theme: isDark ? AppThemes.darkTheme() : AppThemes.lightTheme(),
          debugShowCheckedModeBanner: false,
          locale:
              isArabic ? const Locale('ar', 'EG') : const Locale('en', 'US'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
  }
}
