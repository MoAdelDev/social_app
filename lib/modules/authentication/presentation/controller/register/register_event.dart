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
  final String gender;
  final BuildContext context;

  const RegisterEvent( this.password, this.name, this.phone, this.email, this.gender, this.context);
}

@immutable
class RegisterAddUserEvent extends BaseRegisterEvent {
  final String name;
  final String phone;
  final String gender;
  final BuildContext context;

  const RegisterAddUserEvent( this.name, this.phone, this.gender, this.context);
}

class RegisterSuccessEvent extends BaseRegisterEvent {
  final BuildContext context;
  const RegisterSuccessEvent(this.context);
}
class RegisterShowPasswordEvent extends BaseRegisterEvent {
  const RegisterShowPasswordEvent();
}
