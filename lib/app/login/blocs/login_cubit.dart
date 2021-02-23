
import 'package:arquetipo_flutter_bloc/app/shared/models/password_form_model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/models/username_form_model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'cubit.dart';

class LoginCubit extends Cubit<LoginBlocState> {

  final AuthenticationRepository _authenticationRepository;


  LoginCubit(this._authenticationRepository) : super(LoginBlocState());

  loginUsernameChanged(String userNameText) {

    final username = Username.dirty(userNameText);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.username, username]),
    ));
  }

  loginPasswordChanged(String passwordText) {

    final password = Password.dirty(passwordText);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.password, password]),
    ));
  }


  loginRememberChanged(bool remember) {

    emit(state.copyWith(
      remember: remember
    ));
  }

  loginPasswordVisibilityChanged(bool visibility) {

    emit(state.copyWith(
        pwdVisibility: visibility
    ));
  }


  loginSubmitted() async {
    if(state.isValid()) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
          rememberUser: state.remember,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }

    } else {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}

