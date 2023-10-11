import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/default_animation.dart';
import 'package:social_app/core/components/default_app_bar_icon.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/services/service_locator.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/authentication/presentation/controller/register/register_bloc.dart';
import '../../../../core/components/default_button.dart';
import '../../../../core/components/default_scroll_physics.dart';
import '../../../../core/components/default_text_form_field.dart';
import '../../../../generated/l10n.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(sl(), sl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: DefaultScrollPhysics.bouncing(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.20,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: DefaultAppBarIcon(
                      onPressed: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
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
                            S.of(context).register.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextFormField(
                            controller: _nameController,
                            labelText: S.of(context).nameLabel,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.person,
                            errorText: S.of(context).nameInputError,
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
                            controller: _phoneController,
                            labelText: S.of(context).phoneLabel,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.phone,
                            errorText: S.of(context).phoneInputError,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              return DefaultTextFormField(
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
                                      .read<RegisterBloc>()
                                      .add(const RegisterShowPasswordEvent());
                                },
                                errorText: S.of(context).passwordInputError,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              return ConditionalBuilder(
                                condition:
                                    state.registerState != RequestState.loading,
                                builder: (context) => DefaultButton(
                                    text: S.of(context).signUp.toUpperCase(),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<RegisterBloc>().add(
                                              RegisterEvent(
                                                  _passwordController.text,
                                                  _nameController.text,
                                                  _phoneController.text,
                                                  _emailController.text),
                                            );
                                      }
                                    }),
                                fallback: (context) => const Center(
                                  child: DefaultProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
