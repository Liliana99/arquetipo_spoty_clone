import 'package:arquetipo_flutter_bloc/app/login/blocs/cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/models/password_form_model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/models/username_form_model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  group('LoginCubit', () {
    LoginCubit loginCubit;
    AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      loginCubit = LoginCubit(authenticationRepository);
      when(() => authenticationRepository.logIn(username: 'test', password: 'pwd')).thenAnswer((_) => Future.value());
      when(() => authenticationRepository.logIn(username: 'test', password: 'wrong_password')).thenThrow(new Exception());

    });

    test('initial state is all forms empty', () {
      expect(loginCubit.state.username.value, '');
      expect(loginCubit.state.password.value, '');
    });

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when username changed',
      build: () => loginCubit,
      act: (cubit) => cubit.loginUsernameChanged('test'),
      expect: () => [
        LoginBlocState(
            username: Username.dirty('test'), status: FormzStatus.invalid)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when password changed',
      build: () => loginCubit,
      act: (cubit) => cubit.loginPasswordChanged('pwd'),
      expect: () => [
        LoginBlocState(
            password: Password.dirty('pwd'), status: FormzStatus.invalid)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when loginRemember changed',
      build: () => loginCubit,
      act: (cubit) => cubit.loginRememberChanged(true),
      expect: () => [
        LoginBlocState(
            remember: true)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when password eye visibility changed',
      build: () => loginCubit,
      act: (cubit) => cubit.loginPasswordVisibilityChanged(true),
      expect: () => [
        LoginBlocState(
            pwdVisibility: true)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when submit is called and form is not valid',
      build: () => loginCubit,
      act: (cubit) => cubit.loginSubmitted(),
      expect: () => [
        LoginBlocState(
            status: FormzStatus.submissionFailure)
      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when submit is called and form is valid and repository response is success',
      build: () => loginCubit,
      seed: () => LoginBlocState(
          username: Username.dirty('test'),
          password: Password.dirty('pwd'),
          status: FormzStatus.valid),
      act: (cubit) => cubit.loginSubmitted(),
      expect: () => [
        LoginBlocState(
            username: Username.dirty('test'),
            password: Password.dirty('pwd'),
            status: FormzStatus.submissionInProgress),
        LoginBlocState(
            username: Username.dirty('test'),
            password: Password.dirty('pwd'),
            status: FormzStatus.submissionSuccess),

      ],
    );

    blocTest<LoginCubit, LoginBlocState>(
      'emits new status when submit is called and form is valid and repository response is error',
      build: () => loginCubit,
      seed: () => LoginBlocState(
          username: Username.dirty('test'),
          password: Password.dirty('wrong_password'),
          status: FormzStatus.valid),
      act: (cubit) => cubit.loginSubmitted(),
      expect: () => [
        LoginBlocState(
            username: Username.dirty('test'),
            password: Password.dirty('wrong_password'),
            status: FormzStatus.submissionInProgress),
        LoginBlocState(
            username: Username.dirty('test'),
            password: Password.dirty('wrong_password'),
            status: FormzStatus.submissionFailure),
      ],
    );
  });
}
