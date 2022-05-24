import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  final ThemeData theme = ThemeData();

  return theme.copyWith(
    primaryColor: Colors.blue,
    colorScheme: theme.colorScheme.copyWith(
      secondary: Colors.amberAccent
    ),
  );
}