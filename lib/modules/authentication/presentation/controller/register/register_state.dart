part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final RequestState registerState;
  final String registerError;
  final bool isPasswordHidden;

  const RegisterState({
    this.registerState = RequestState.nothing,
    this.registerError = '',
    this.isPasswordHidden = true,
  });

  RegisterState copyWith({
    RequestState? registerState,
    String? registerError,
    bool? isPasswordHidden,
  }) =>
      RegisterState(
        registerState: registerState ?? this.registerState,
        registerError: registerError ?? this.registerError,
        isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      );

  @override
  List<Object> get props => [
        registerState,
        registerError,
        isPasswordHidden,
      ];
}
