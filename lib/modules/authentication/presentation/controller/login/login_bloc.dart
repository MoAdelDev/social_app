import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';

import '../../../domain/usecase/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<BaseLoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(const LoginState()) {
    on<LoginShowPasswordEvent>(_showPassword);
    on<LoginEvent>(_login);
  }

  FutureOr<void> _showPassword(
      LoginShowPasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  FutureOr<void> _login(LoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginState: RequestState.loading));
    final result =
        await loginUseCase(email: event.email, password: event.password);
    result.fold((error) {
      AppToast.showToast(msg: error.message, state: RequestState.error);
      emit(state.copyWith(
          loginState: RequestState.error, loginError: error.message));
    }, (right) {
      AppToast.showToast(
          msg: S.of(event.context).loginSuccessMsg,
          state: RequestState.success);
      Navigator.pushNamedAndRemoveUntil(
        event.context,
        AppRouter.kHomeScreen,
        (route) => false,
      );
      emit(state.copyWith(loginState: RequestState.success));
    });
  }
}
