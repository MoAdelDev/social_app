
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<BaseLoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<BaseLoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
