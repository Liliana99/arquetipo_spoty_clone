// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `invalid username`
  String get invalidUsername {
    return Intl.message(
      'invalid username',
      name: 'invalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `invalid password`
  String get invalidPassword {
    return Intl.message(
      'invalid password',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember user`
  String get rememberUser {
    return Intl.message(
      'Remember user',
      name: 'rememberUser',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Inicio`
  String get menuHome {
    return Intl.message(
      'Inicio',
      name: 'menuHome',
      desc: '',
      args: [],
    );
  }

  /// `Más`
  String get menuMore {
    return Intl.message(
      'Más',
      name: 'menuMore',
      desc: '',
      args: [],
    );
  }

  /// `Random`
  String get menuRandom {
    return Intl.message(
      'Random',
      name: 'menuRandom',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get menuLogout {
    return Intl.message(
      'Logout',
      name: 'menuLogout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}