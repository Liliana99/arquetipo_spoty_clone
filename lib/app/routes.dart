import 'package:arquetipo_flutter_bloc/app/home/pages/home_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/more_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/random_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/login_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/splash_page.dart';
import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_bloc.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter buildRoutes(AuthenticationBloc bloc) {
  return GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => HomePage(),
      ),
      GoRoute(
        path: '/more',
        builder: (BuildContext context, GoRouterState state) => MorePage(),
      ),
      GoRoute(
        path: '/random',
        builder: (BuildContext context, GoRouterState state) => RandomPage(),
      ),
    ],
    redirect: (state) {
      if (bloc.state.status == AuthenticationStatus.authenticated) {
        return state.subloc == '/home'? null : '/home';
      } else if (bloc.state.status == AuthenticationStatus.unauthenticated) {
        return  state.subloc == '/login' ? null : '/login';
      }
    },
    refreshListenable: GoRouterRefreshStream(bloc.stream)
  );
}
