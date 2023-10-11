import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:social_app/core/components/default_animation.dart';
import 'package:social_app/core/components/default_button.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/components/default_scroll_physics.dart';
import 'package:social_app/core/components/default_text_form_field.dart';
import 'package:social_app/core/style/fonts.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/authentication/presentation/controller/login/login_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(sl()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              physics: DefaultScrollPhysics.bouncing(),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.20,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  DefaultAnimation(
                    animationDirection: AnimationDirection.up,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.80,
                      color: Theme.of(context).colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                S.of(context).login.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              DefaultTextFormField(
                                controller: _emailController,
                                labelText: S.of(context).emailLabel,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                prefixIcon: Icons.email,
                                errorText: S.of(context).emailInputError,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              DefaultTextFormField(
                                controller: _passwordController,
                                labelText: S.of(context).passwordLabel,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                prefixIcon: Icons.lock,
                                suffixIcon: state.isPasswordHidden
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                obscureText: state.isPasswordHidden,
                                onSuffixIcon: () {
                                  context
                                      .read<LoginBloc>()
                                      .add(const LoginShowPasswordEvent());
                                },
                                errorText: S.of(context).passwordInputError,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      S
                                          .of(context)
                                          .forgotPasswordQuestion
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontFamily: AppFonts.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ConditionalBuilder(
                                condition:
                                    state.loginState != RequestState.loading,
                                builder: (context) {
                                  return DefaultButton(
                                      text: S.of(context).login.toUpperCase(),
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          context.read<LoginBloc>().add(
                                              LoginEvent(
                                                  _emailController.text,
                                                  _passwordController.text,
                                                  context));
                                        }
                                      });
                                },
                                fallback: (context) => const Center(
                                  child: DefaultProgressIndicator(),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).registerQuestion,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      AppRouter.kRegisterScreen,
                                    ),
                                    child: SizedBox(
                                      child: Text(
                                        S.of(context).register.toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontFamily: AppFonts.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
