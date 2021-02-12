import 'dart:developer';

import 'package:arquetipo_flutter_bloc/shared/blocs/authentication/bloc.dart';
import 'package:arquetipo_flutter_bloc/shared/repositories/authentication_repository.dart';
import 'package:arquetipo_flutter_bloc/shared/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository()),
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('test');
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
          title: 'Flutter Demo',
/*        localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            S.delegate],
          supportedLocales: S.delegate.supportedLocales,*/
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: routes),
    );
  }
}
