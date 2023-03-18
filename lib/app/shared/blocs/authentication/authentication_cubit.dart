import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../repositories/authentication_repository.dart';
import 'authentication_state_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository repository;

  AuthenticationCubit(AuthenticationState initialState, this.repository)
      : super(initialState) {
    repository.status.listen(
        (status) => emit(_mapAuthenticationStatusChangedToState(status)));
  }

  initAuthentication() async {
    if (state.status == AuthenticationStatus.unknown) {
      UserModel? userModel = await repository.getUsermodel();

      if (userModel != null) {
        emit(AuthenticationState.authenticated(userModel));
        return;
      }
      emit(const AuthenticationState.unauthenticated());
    }
  }

  authenticationLogoutRequested() async {
    repository.logOut();
  }

  AuthenticationState _mapAuthenticationStatusChangedToState(
      AuthenticationStatus status) {
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return AuthenticationState.authenticated(repository.userModel);
      default:
        return const AuthenticationState.unknown();
    }
  }
}
