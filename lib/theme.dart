import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  final ThemeData theme = ThemeData();
  const primaryColor = Colors.purple;
  const secondaryColor = Colors.indigoAccent;

  return theme.copyWith(
    //useMaterial3: true,
    brightness: Brightness.dark,

    // An App bar example for customization
    appBarTheme: theme.appBarTheme.copyWith(centerTitle: true),

    /// Color palette settings
    primaryColor: primaryColor,
    colorScheme: theme.colorScheme
        .copyWith(primary: primaryColor, secondary: secondaryColor),

    /// Text style settings
    textTheme: theme.textTheme
        .copyWith(displayLarge: const TextStyle(color: Colors.black54)),
    textSelectionTheme: theme.textSelectionTheme
        .copyWith(cursorColor: Colors.green, selectionColor: Colors.red),

    /// Button style settings
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        /// Configure button elevation based on button states
        elevation: MaterialStateProperty.resolveWith<double>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return 4.0;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.disabled)) {
              return 0;
            }
            return 5.0;
          },
        ),

        /// Configure button elevation based on button states
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return primaryColor.withOpacity(0.2);
            }
            // if (states.contains(MaterialState.) ||
            //     states.contains(MaterialState.pressed)) return blue1;

            /// The value of constant values cannot be read from this
            /// themedata because these values still are not injected in
            /// Widgets tree hierachy.
            return primaryColor; // Defer to the widget's default.
          },
        ),
      ),
    ),
    inputDecorationTheme: theme.inputDecorationTheme.copyWith(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 1),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      errorStyle: const TextStyle(color: Colors.red),

      /// Some additional colors to be cutomized
      // hoverColor: Colors.green,
      // focusColor: Colors.orange,
      // fillColor: Colors.yellow,
      // iconColor: Colors.red,
      activeIndicatorBorder: const BorderSide(color: primaryColor),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 3),
      ),
    ),
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

  TextStyle? get button => Theme.of(this).textTheme.titleLarge;
}
