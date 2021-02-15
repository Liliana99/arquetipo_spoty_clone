import 'package:arquetipo_flutter_bloc/shared/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationBlocEvent extends Equatable {
  const AuthenticationBlocEvent();
}

class AuthenticationStatusChanged extends AuthenticationBlocEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationBlocEvent {
  @override
  List<Object> get props => [];
}
