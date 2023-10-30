import 'dart:async';

import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/home_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/more_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/random_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/pages/song_page.dart';
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
          path: '/splash',
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
          builder: (BuildContext context, GoRouterState state) => HomePage(),
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
        GoRoute(
          path: '/songpage',
          pageBuilder: (context, state) => getSlideTransitionPage(
            context: context,
            state: state,
            child: SongContent(songItem: state.extra! as SongModel),
          ),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final authStatus = bloc.state.status;

        if (authStatus == AuthenticationStatus.authenticated) {
          return state.matchedLocation.contains('/login') ||
                  state.matchedLocation == '/'
              ? '/home'
              : null;
        } else if (authStatus == AuthenticationStatus.unauthenticated) {
          return '/splash';
        } else if (authStatus == AuthenticationStatus.unknown) {
          return '/login';
        }

        return '/';
      },
      refreshListenable: GoRouterRefreshStream(bloc.stream));
}

CustomTransitionPage getSlideTransitionPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: ClipRect(child: child),
      );
    },
  );
}
