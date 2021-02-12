import 'package:arquetipo_flutter_bloc/shared/models/password_form_model.dart';
import 'package:arquetipo_flutter_bloc/shared/models/username_form_model.dart';
import 'package:arquetipo_flutter_bloc/shared/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {

  final AuthenticationRepository _authenticationRepository;


  LoginBloc(this._authenticationRepository) : super(LoginBlocState());

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginRememberChanged) {
      yield _mapRememberChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginBlocState _mapUsernameChangedToState(LoginUsernameChanged event, LoginBlocState state) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.username, username]),
    );
  }

  LoginBlocState _mapPasswordChangedToState(LoginPasswordChanged event, LoginBlocState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([state.password, password]),
    );
  }


  LoginBlocState _mapRememberChangedToState(LoginRememberChanged event, LoginBlocState state) {
    final remember = event.remember;
    return state.copyWith(
      remember: remember
    );
  }

  Stream<LoginBlocState> _mapLoginSubmittedToState(LoginSubmitted event, LoginBlocState state) async* {
    if(state.isValid()) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }

    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}

