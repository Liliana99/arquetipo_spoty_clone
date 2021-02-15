import 'dart:async';

import 'package:arquetipo_flutter_bloc/shared/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationBlocEvent, AuthenticationState> {

  final AuthenticationRepository repository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;


  AuthenticationBloc(AuthenticationState initialState, this.repository) : super(initialState) {
    _authenticationStatusSubscription = this.repository.status.listen(
            (status) => add(AuthenticationStatusChanged(status)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationBlocEvent event) async* {
    // TODO: implement mapEventToState
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
        final user = await _tryGetUser();
        return AuthenticationState.authenticated(user);
      default:
        return const AuthenticationState.unknown();
    }
  }

  Future<dynamic> _tryGetUser() async {
    try {
/*      final user = await _userRepository.getUser();
      return user;*/
    return null;
    } on Exception {
      return null;
    }
  }
}