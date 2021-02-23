import 'dart:async';
import 'package:arquetipo_flutter_bloc/app/shared/models/user-model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationBlocEvent, AuthenticationState> {

  final AuthenticationRepository repository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;


  AuthenticationBloc(AuthenticationState initialState, this.repository) : super(initialState) {
    _authenticationStatusSubscription = this.repository.status.listen(
            (status) => add(AuthenticationStatusChanged(status, repository.userModel)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationBlocEvent event) async* {
    if(this.state.status == AuthenticationStatus.unknown) {
      UserModel userModel = await repository.getUsermodel();
      if(userModel != null) {
        add(AuthenticationStatusChanged(AuthenticationStatus.authenticated, userModel));
      }
    }
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      repository.logOut();
    }
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