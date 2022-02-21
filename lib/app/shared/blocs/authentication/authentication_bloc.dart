import 'dart:async';
import 'package:arquetipo_flutter_bloc/app/shared/models/user-model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationBlocEvent, AuthenticationState> {

  final AuthenticationRepository repository;
  StreamSubscription<AuthenticationStatus>? _authenticationStatusSubscription;


  AuthenticationBloc(AuthenticationState initialState, this.repository) : super(initialState) {

    on<AuthenticationBlocEvent>((event, emit) async {
      if(this.state.status == AuthenticationStatus.unknown) {
        UserModel? userModel = await repository.getUsermodel();
        if(userModel != null) {
          emit(await _mapAuthenticationStatusChangedToState(AuthenticationStatusChanged(AuthenticationStatus.authenticated, userModel)));
          return;
        }
      }
      if (event is AuthenticationStatusChanged) {
        emit(await _mapAuthenticationStatusChangedToState(event));
      } else if (event is AuthenticationLogoutRequested) {
        repository.logOut();
      }
    });
    _authenticationStatusSubscription = this.repository.status.listen(
            (status) => add(AuthenticationStatusChanged(status, repository.userModel)));
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    repository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return AuthenticationState.authenticated(event.userModel);
      default:
        return const AuthenticationState.unknown();
    }
  }
}