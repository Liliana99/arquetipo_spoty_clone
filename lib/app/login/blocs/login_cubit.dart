import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class LoginCubit extends Cubit<LoginBlocState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(const LoginBlocState());

  formChanged(Map<String, dynamic> values, bool valid) {
    emit(state.copyWith(status: valid, value: values));
  }

  loginPasswordVisibilityChanged(bool visibility) {
    emit(state.copyWith(pwdVisibility: visibility));
  }

  loginSubmitted() async {
    if (state.isValid()) {
      try {
        await _authenticationRepository.logIn(
          username: state.value['userName'],
          password: state.value['password'],
          
        );
        emit(state.copyWith(submissionInProgress: false));
      } on Exception catch (_) {
        emit(state.copyWith(submissionInProgress: false));
      }
    } else {
      emit(state.copyWith(submissionInProgress: false));
    }
  }

  splashTap() async {
    try {
      await _authenticationRepository.doSplash();
      emit(state.copyWith(submissionInProgress: false));
    } on Exception catch (_) {
      emit(state.copyWith(submissionInProgress: false));
    }
  }

  void backToSplash() async {
    try {
      await _authenticationRepository.backToSplashPage();
      emit(state.copyWith(submissionInProgress: false));
    } on Exception catch (_) {
      emit(state.copyWith(submissionInProgress: false));
    }
  }

  void loginWithOutPassword() async {
    try {
      emit(state.copyWith(submissionInProgress: true));
      _authenticationRepository.logInWithOutPassword();
    } on Exception catch (_) {
      emit(state.copyWith(submissionInProgress: false));
    }
  }
}
