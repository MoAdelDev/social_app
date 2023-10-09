part of 'register_bloc.dart';

abstract class BaseRegisterEvent {
  const BaseRegisterEvent();
}

@immutable
class RegisterEvent extends BaseRegisterEvent {
  final String password;
  final String name;
  final String phone;
  final String email;

  const RegisterEvent( this.password, this.name, this.phone, this.email);
}

@immutable
class RegisterAddUserEvent extends BaseRegisterEvent {
  final String name;
  final String phone;

  const RegisterAddUserEvent( this.name, this.phone);
}

class RegisterSuccessEvent extends BaseRegisterEvent {
  const RegisterSuccessEvent();
}
class RegisterShowPasswordEvent extends BaseRegisterEvent {
  const RegisterShowPasswordEvent();
}
