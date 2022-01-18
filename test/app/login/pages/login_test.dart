import 'package:arquetipo_flutter_bloc/app/login/blocs/cubit.dart';
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
    registerFallbackValue(LoginBlocState());
  });

  group('LoginScreen', () {
    MockLoginCubit? loginBloc;

    setUp(() {
      loginBloc = MockLoginCubit();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await buildWidget(loginBloc, tester);

      // Verify that our counter starts at 0.
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('username changes correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await buildWidget(loginBloc, tester);
      await tester.enterText(find.byKey(Key('loginForm_usernameInput_textField')), 'test');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      verify(() => loginBloc!.formChanged(GlobalKey<FormBuilderState>())).called(1);
    });

    testWidgets('password changesCorrectly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await buildWidget(loginBloc, tester);
      await tester.enterText(find.byKey(Key('loginForm_passwordInput_textField')), 'test');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      verify(() => loginBloc!.loginPasswordChanged('test')).called(1);
    });

    testWidgets('password eyeIcon changes correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await buildWidget(loginBloc, tester);
      await tester.tap(find.byKey(Key('loginForm_eyeIcon_button')));
      await tester.pumpAndSettle();
      verify(() => loginBloc!.loginPasswordVisibilityChanged(true)).called(1);
    });

    testWidgets('remember changesCorrectly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await buildWidget(loginBloc, tester);
      await tester.tap(find.byKey(Key('loginForm_remember_textField')));
      await tester.pumpAndSettle();
      verify(() => loginBloc!.loginRememberChanged(true)).called(1);
    });

    testWidgets('submit button called correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await buildWidget(loginBloc, tester);
      await tester.tap(find.byKey(Key('loginForm_submit_button')));
      await tester.pumpAndSettle();
      verify(() => loginBloc!.loginSubmitted()).called(1);
    });

    testWidgets('show in progress when status is in progress', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state).thenAnswer((_) => LoginBlocState(status: FormzStatus.submissionInProgress));
      await tester.pumpWidget(BlocProvider<LoginCubit>(
          create: (context) => loginBloc!,
          child: MaterialApp(home: LoginContent(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: S.supportedLocales,
          )));

      await tester.pump();
      expect(find.byKey(Key('circular_progress_indicator')), findsOneWidget);
    });
  });
}

Future buildWidget(MockLoginCubit? loginBloc, WidgetTester tester) async {
  when(() => loginBloc!.state).thenAnswer((_) => LoginBlocState(username: Username.dirty('test'), password: Password.dirty('test')));
  await tester.pumpWidget(BlocProvider<LoginCubit>(
      create: (context) => loginBloc!,
      child: MaterialApp(home: LoginContent(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.supportedLocales,
      )));
  
  await tester.pumpAndSettle();
}
