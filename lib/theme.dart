import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Proxima',
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromRGBO(88, 89, 89, 1),
      // TRY THIS: Change to "Brightness.light"
      //           and see that all colors change
      //           to better contrast a light background.
      primary: const Color.fromARGB(77, 142, 140, 140),
      onPrimaryContainer: const Color.fromARGB(77, 121, 119, 119),

      brightness: Brightness.dark,
    ),
  );

  return theme.copyWith(
    // An App bar example for customization
    appBarTheme: theme.appBarTheme.copyWith(centerTitle: true),
  );
}

/// Theme extension styles
///
/// To use it you only need to type `context.dispL` to get displayLarge style
/// and so on with the rest of styles, instead of:
/// `Theme.of(context).textTheme.displayLarge`
extension UIThemeExtension on BuildContext {
  TextStyle? get dispL => Theme.of(this).textTheme.displayLarge;
  TextStyle? get dispM => Theme.of(this).textTheme.displayMedium;
  TextStyle? get dispS => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headL => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headM => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headS => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get titleL => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleM => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleS => Theme.of(this).textTheme.titleSmall;

  TextStyle? get bodyL => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyM => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodyS => Theme.of(this).textTheme.bodySmall;
}
