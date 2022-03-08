import 'package:arquetipo_flutter_bloc/app/login/blocs/cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('LoginCubit', () {
    late LoginCubit loginCubit;
    AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      loginCubit = LoginCubit(authenticationRepository);
      when(() =>
              authenticationRepository.logIn(username: 'test', password: 'pwd'))
          .thenAnswer((_) => Future.value());
      when(() => authenticationRepository.logIn(
          username: 'test',
          password: 'wrong_password')).thenThrow(new Exception());
    });

    test('initial state is all forms empty', () {
      expect(loginCubit.state.value['username'], '');
      expect(loginCubit.state.value['password'], '');
      expect(loginCubit.state.value['remember'], false);
    });

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when username changed',
      build: () => loginCubit,
      act: (cubit) => cubit.formChanged(GlobalKey<FormBuilderState>()
        ..currentState!.patchValue({'username': 'test'})),
      expect: () => [
        LoginBlocState(value: {'username': 'test'}, status: false)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when password changed',
      build: () => loginCubit,
      act: (cubit) => cubit.formChanged(GlobalKey<FormBuilderState>()
        ..currentState!.patchValue({'password': 'test'})),
      expect: () => [
        LoginBlocState(value: {'password': 'test'}, status: false)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when loginRemember changed',
      build: () => loginCubit,
      act: (cubit) => cubit.formChanged(GlobalKey<FormBuilderState>()
        ..currentState!.patchValue({'remember': true})),
      expect: () => [
        LoginBlocState(value: {'remember': true}, status: false)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when password eye visibility changed',
      build: () => loginCubit,
      act: (cubit) => cubit.loginPasswordVisibilityChanged(true),
      expect: () => [LoginBlocState(pwdVisibility: true)],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when submit is called and form is not valid',
      build: () => loginCubit,
      act: (cubit) => cubit.loginSubmitted(),
      expect: () => [LoginBlocState(submissionInProgress: false)],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when submit is called and form is valid and repository response is success',
      build: () => loginCubit,
      seed: () => LoginBlocState(
          value: {'username': 'test', 'password': 'pwd'}, status: true),
      act: (cubit) => cubit.loginSubmitted(),
      expect: () => [
        LoginBlocState(
            value: {'username': 'test', 'password': 'pwd'},
            submissionInProgress: true,
            status: true),
        LoginBlocState(
            value: {'username': 'test', 'password': 'pwd'},
            submissionInProgress: false,
            status: true),
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when submit is called and form is valid and repository response is error',
      build: () => loginCubit,
      seed: () => LoginBlocState(
          value: {'username': 'test', 'password': 'pwd'}, status: true),
      act: (cubit) => cubit.loginSubmitted(),
      expect: () => [
        LoginBlocState(
            value: {'username': 'test', 'password': 'pwd'},
            submissionInProgress: true,
            status: true),
        LoginBlocState(
            value: {'username': 'test', 'password': 'pwd'},
            submissionInProgress: false,
            status: true),
      ],
    );
  });
}
