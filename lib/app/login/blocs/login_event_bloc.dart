import 'package:equatable/equatable.dart';

abstract class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginBlocEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginBlocEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginPasswordVisibilityChanged extends LoginBlocEvent {
  const LoginPasswordVisibilityChanged(this.visibility);
  final bool visibility;
  @override
  List<Object> get props => [visibility];
}

class LoginRememberChanged extends LoginBlocEvent {
  const LoginRememberChanged(this.remember);

  final bool remember;

  @override
  List<Object> get props => [remember];
}

class LoginSubmitted extends LoginBlocEvent {
  const LoginSubmitted();

  @override
  List<Object> get props => [];
}