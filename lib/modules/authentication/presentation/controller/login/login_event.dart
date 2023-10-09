part of 'login_bloc.dart';

abstract class BaseLoginEvent {
  const BaseLoginEvent();
}

class LoginShowPasswordEvent extends BaseLoginEvent {
  const LoginShowPasswordEvent();
}

class LoginEvent extends BaseLoginEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);
}
