import 'package:arquetipo_flutter_bloc/app/shared/models/user-model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationBlocEvent extends Equatable {
  const AuthenticationBlocEvent();
}

class AuthenticationStatusChanged extends AuthenticationBlocEvent {
  const AuthenticationStatusChanged(this.status, this.userModel);

  final AuthenticationStatus status;
  final UserModel? userModel;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationBlocEvent {
  @override
  List<Object> get props => [];
}