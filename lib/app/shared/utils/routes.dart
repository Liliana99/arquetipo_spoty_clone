import 'package:arquetipo_flutter_bloc/app/home/pages/home_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/more_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/random_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/login_page.dart';
import 'package:arquetipo_flutter_bloc/app/login/pages/splash_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => SplashPage(),
  '/login': (context) => LoginPage(),
  '/home': (context) => HomePage(),
  '/more': (context) => MorePage(),
  '/random': (context) => RandomPage()
};