import 'dart:ui';

import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:arquetipo_flutter_bloc/theme.dart';
import 'package:go_router/go_router.dart';
import 'shared/blocs/error/error_cubit.dart';
import 'routes.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late GoRouter router;

  @override
  void initState() {
    router = buildRoutes(BlocProvider.of<AuthenticationCubit>(context));
    super.initState();
  }

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
        scrollBehavior: MyCustomScrollBehavior(),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.supportedLocales,
        theme: buildThemeData(),
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        builder: (context, child) {
          return BlocListener<ErrorCubit, DioError?>(
            listenWhen: (previous, current) => current != null,
            listener: (context, state) =>
                buildErrorDialog(context, state, router),
            child: child,
          );
        },
      ),
    );
  }

  // unified error handler
  Future<dynamic> buildErrorDialog(
      BuildContext context, DioError? state, GoRouter router) {
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
