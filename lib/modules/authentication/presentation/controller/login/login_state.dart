part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isPasswordHidden;
  final User? user;
  final RequestState loginState;
  final String loginError;

  const LoginState({
    this.user,
    this.isPasswordHidden = true,
    this.loginState = RequestState.nothing,
    this.loginError = '',
  });

  LoginState copyWith({
    bool? isPasswordHidden,
    RequestState? loginState,
    String? loginError,
    User? user,
  }) =>
      LoginState(
        isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
        loginState: loginState ?? this.loginState,
        loginError: loginError ?? this.loginError,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [
        isPasswordHidden,
        user,
        loginState,
        loginError,
      ];
}
