import 'dart:async';

import 'package:arquetipo_flutter_bloc/app/home/pages/home_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/more_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/random_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/login_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/splash_page.dart';
import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter buildRoutes(AuthenticationCubit bloc) {
  return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) =>
              HomePage(),
        ),
        GoRoute(
          path: '/more',
          builder: (BuildContext context, GoRouterState state) =>
              const MorePage(),
        ),
        GoRoute(
          path: '/random',
          builder: (BuildContext context, GoRouterState state) =>
              const RandomPage(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        if (bloc.state.status == AuthenticationStatus.authenticated) {
          return state.matchedLocation.contains('/login') || state.matchedLocation == '/'
              ? '/home'
              : null;
        } else if (bloc.state.status == AuthenticationStatus.unauthenticated) {
          return state.matchedLocation.contains('/login') ? null : '/login';
        }
        return '/';
      },
      refreshListenable: GoRouterRefreshStream(bloc.stream));
}
