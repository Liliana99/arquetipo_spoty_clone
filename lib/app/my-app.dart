import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_bloc.dart';
import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_state_bloc.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:arquetipo_flutter_bloc/theme.dart';
import 'package:go_router/go_router.dart';

import 'home/pages/home_page.dart';
import 'login/pages/login_page.dart';
import 'shared/blocs/error/error_cubit.dart';
import 'shared/utils/routes.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Flutter Demo',
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
        theme: buildThemeData(),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<ErrorCubit, DioError?>(
                listenWhen: (previous, current) => current != null,
                listener: (context, state) => buildErrorDialog(context, state),
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  router.go('/home');
                } else if (state.status == AuthenticationStatus.unauthenticated) {
                  router.go('/login');
                }
              },
            )],
            child: child!,
          );
        },
      ),
    );
  }
  // unified error handler
  Future<dynamic> buildErrorDialog(BuildContext context, DioError? state) {
    return showDialog(
        context: router.navigator!.context,
        builder: (_) => AlertDialog(
          title: Text(S.of(context)!.errorServiceTitle),
          content: Text(state!.message),
          actions: [
            TextButton(
              child: Text(S.of(context)!.accept),
              onPressed: () {
                Navigator.pop(router.navigator!.context);
              },
            ),
          ],
        ));
  }
}
