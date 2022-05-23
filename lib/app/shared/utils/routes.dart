import 'package:arquetipo_flutter_bloc/app/home/pages/home_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/more_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/random_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/login_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
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
);
