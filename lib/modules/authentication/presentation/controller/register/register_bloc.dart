import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';
import 'package:social_app/modules/authentication/domain/usecase/register_usecase.dart';

import '../../../domain/usecase/add_user_usecase.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<BaseRegisterEvent, RegisterState> {
  final AddUserUseCase addUserUseCase;
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.addUserUseCase, this.registerUseCase)
      : super(const RegisterState()) {
    on<RegisterEvent>(_register);
    on<RegisterAddUserEvent>(_addUser);
    on<RegisterShowPasswordEvent>(_showPassword);
    on<RegisterSuccessEvent>((event, emit) =>
        emit(state.copyWith(registerState: RequestState.success)));
  }

  FutureOr<void> _register(
      RegisterEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(registerState: RequestState.loading));
    final result =
        await registerUseCase(email: event.email, password: event.password);

    result.fold((error) {
      AppToast.showToast(msg: error.message, state: RequestState.error);
      emit(state.copyWith(
          registerState: RequestState.error, registerError: error.message));
    }, (right) {
      // Add user
      add(RegisterAddUserEvent(event.name, event.phone));
    });
  }

  FutureOr<void> _addUser(
      RegisterAddUserEvent event, Emitter<RegisterState> emit) async {
    UserModel userModel = UserModel(
      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
      name: event.name,
      email: FirebaseAuth.instance.currentUser?.email ?? '',
      photo: '',
      phone: event.phone,
    );

    final result = await addUserUseCase(userModel: userModel);
    result.fold((error) {
      AppToast.showToast(msg: error.message, state: RequestState.error);
      emit(state.copyWith(
          registerState: RequestState.error, registerError: error.message));
    }, (user) {
      AppToast.showToast(
          msg: "You have been registered successfully",
          state: RequestState.success);
      MyApp.user = userModel;
      add(const RegisterSuccessEvent());
    });
  }

  FutureOr<void> _showPassword(
      RegisterShowPasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }
}
