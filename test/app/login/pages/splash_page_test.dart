import 'package:arquetipo_flutter_bloc/app/login/blocs/login_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/login/blocs/login_state_bloc.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/splash_page.dart';
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

  group('SplashScreen', () {
    MockLoginCubit? loginBloc;

    setUp(() {
      loginBloc = MockLoginCubit();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state).thenAnswer((_) => const LoginBlocState(
          value: {'username': 'test', 'password': 'test'}));
      await buildWidget(loginBloc, tester);
     await tester.pumpAndSettle();

      expect(find.text('Milions of songs.'), findsOneWidget);

      expect(find.text('Registrate gratis'), findsOneWidget);

      expect(find.text('Continua con Google'), findsOneWidget);

      expect(find.text('Continua con Facebook'), findsOneWidget);
    });

    testWidgets('submit button  acceder called correctly',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      when(() => loginBloc!.state)
          .thenAnswer((_) => const LoginBlocState(status: true));
      await buildWidget(loginBloc, tester);
      await tester.tap(find.text("Acceder"));
      await tester.pumpAndSettle();
      verify(() => loginBloc!.splashTap()).called(1);
    });
  });
}

Future buildWidget(MockLoginCubit? loginBloc, WidgetTester tester) async {
  await tester.pumpWidget(BlocProvider<LoginCubit>(
      create: (context) => loginBloc!,
      child: const MaterialApp(
        home: SplashContent(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.supportedLocales,
      )));

  await tester.pumpAndSettle();
}
