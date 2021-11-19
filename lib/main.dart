import 'package:arquetipo_flutter_bloc/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/home/pages/home_page.dart';
import 'app/login/pages/login_page.dart';
import 'app/shared/blocs/authentication/authentication_bloc.dart';
import 'app/shared/blocs/authentication/authentication_state_bloc.dart';
import 'app/shared/repositories/authentication_repository.dart';
import 'app/shared/repositories/storage_repository.dart';
import 'app/shared/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  final StorageRepository storageRepository = StorageRepository();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(storageRepository)),
      RepositoryProvider<StorageRepository>(
          create: (context) => storageRepository),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
                AuthenticationState.unknown(),
                RepositoryProvider.of<AuthenticationRepository>(context)))
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
        theme: buildThemeData(),
        navigatorKey: _navigatorKey,
        initialRoute: '/',
        routes: routes,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                _navigator.pushAndRemoveUntil(
                    HomePage.route(), (route) => false);
              } else if (state.status == AuthenticationStatus.unauthenticated) {
                _navigator.pushAndRemoveUntil(
                    LoginPage.route(), (route) => false);
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
