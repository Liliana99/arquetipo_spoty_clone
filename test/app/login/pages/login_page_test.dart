import 'package:arquetipo_flutter_bloc/app/login/blocs/login_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/login/blocs/login_state_bloc.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/login_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockLoginCubit extends MockCubit<LoginBlocState> implements LoginCubit {}

class FakeLoginBlocState extends Fake implements LoginBlocState {}

void main() {
  setUpAll(() {
    registerFallbackValue(const LoginBlocState());
  });

  group('LoginScreen', () {
    MockLoginCubit? loginBloc;

    setUp(() {
      loginBloc = MockLoginCubit();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state).thenAnswer((_) => const LoginBlocState(
          value: {'username': 'test', 'password': 'test'}));
      await buildWidget(loginBloc, tester);

      // Verify that our counter starts at 0.
      expect(find.text('Email or username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('username changes correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state).thenAnswer((_) => const LoginBlocState(
          value: {'username': 'test', 'password': 'test'}));
      await buildWidget(loginBloc, tester);
      await tester.enterText(
          find.byKey(const Key('loginForm_usernameInput_textField')), 'test');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      verify(() => loginBloc!.formChanged(
              {'userName': 'test', 'password': null,}, false))
          .called(1);
    });

    testWidgets('password eyeIcon changes correctly',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state).thenAnswer((_) => const LoginBlocState(
          value: {'username': 'test', 'password': 'test'}));
      await buildWidget(loginBloc, tester);
      await tester.tap(find.byKey(const Key('loginForm_eyeIcon_button')));
      await tester.pumpAndSettle();
      verify(() => loginBloc!.loginPasswordVisibilityChanged(true)).called(1);
    });

    testWidgets('submit button called correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state)
          .thenAnswer((_) => const LoginBlocState(status: true));
      await buildWidget(loginBloc, tester);
      await tester.tap(find.byKey(const Key('loginForm_submit_button')));
      await tester.pumpAndSettle();
      verify(() => loginBloc!.loginSubmitted()).called(1);
    });

     testWidgets('submit button  withoutpassword called correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state)
          .thenAnswer((_) => const LoginBlocState(status: true));
      await buildWidget(loginBloc, tester);
      await tester.tap(find.text("Log in without password"));
      await tester.pumpAndSettle();
      verify(() => loginBloc!.loginWithOutPassword()).called(1);
    });

    testWidgets('show in progress when status is in progress',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state)
          .thenAnswer((_) => const LoginBlocState(submissionInProgress: true));
      await tester.pumpWidget(BlocProvider<LoginCubit>(
          create: (context) => loginBloc!,
          child: const MaterialApp(
            home: LoginContent(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: S.supportedLocales,
          )));

      await tester.pump();
      expect(
          find.byKey(const Key('circular_progress_indicator')), findsOneWidget);
    });
  });
}

Future buildWidget(MockLoginCubit? loginBloc, WidgetTester tester) async {
  await tester.pumpWidget(BlocProvider<LoginCubit>(
      create: (context) => loginBloc!,
      child: const MaterialApp(
        home: LoginContent(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.supportedLocales,
      )));

  await tester.pumpAndSettle();
}