import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'cubit.dart';

class LoginCubit extends Cubit<LoginBlocState> {

  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(LoginBlocState());

  formChanged(GlobalKey<FormBuilderState> form) {
    form.currentState!.save();
    emit(state.copyWith(
      status: form.currentState!.validate(),
      value: form.currentState!.value
    ));
  }

  loginPasswordVisibilityChanged(bool visibility) {

    emit(state.copyWith(
        pwdVisibility: visibility
    ));
  }

  loginSubmitted() async {
    if(state.isValid()) {
      emit(state.copyWith(submissionInProgress: true));

      try {
        await _authenticationRepository.logIn(
          username: state.value['userName'],
          password: state.value['password'],
          rememberUser: state.value['remember'],
        );
        emit(state.copyWith(submissionInProgress: false));
      } on Exception catch (_) {
        emit(state.copyWith(submissionInProgress: false));
      }

    } else {
      emit(state.copyWith(submissionInProgress: false));
    }
  }

}

