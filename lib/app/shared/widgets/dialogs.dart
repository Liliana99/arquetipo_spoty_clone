import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

import '../blocs/version/version_state_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../repositories/version_repository.dart';



Future<dynamic> buildErrorDialog(
    BuildContext context, DioError? state, GoRouter router) {
  final navigationContext =
  router.routerDelegate.navigatorKey.currentContext!;
  return showDialog(
      context: navigationContext,
      builder: (_) => AlertDialog(
        title: Text(S.of(context)!.errorServiceTitle),
        content: Text(state?.message ?? ''),
        actions: [
          TextButton(
            child: Text(S.of(context)!.accept),
            onPressed: () {
              Navigator.pop(navigationContext);
            },
          ),
        ],
      ));
}

// unified error handler
Future<dynamic> buildVersionBlockDialog(
    BuildContext context, VersionStateCubit state, GoRouter router) {
  final navigationContext =
  router.routerDelegate.navigatorKey.currentContext!;
  return showDialog(
      context: navigationContext,
      barrierDismissible: state.versionState == VERSION_TYPES.OPTIONAL_UPDATE,
      builder: (_) => AlertDialog(
        title: state.versionState == VERSION_TYPES.MANDATORY_UPDATE ? Text(S.of(context)!.errorServiceTitle) : Text(S.of(context)!.errorServiceTitle),
        content: Text('Hay una actualización blabalbalab: ${state.versionState}'),
        actions: [
          TextButton(
            child: Text(S.of(context)!.accept),
            onPressed: state.versionState == VERSION_TYPES.MANDATORY_UPDATE ? null : () {
              Navigator.pop(navigationContext);
            },
          ),
        ],
      ));
}